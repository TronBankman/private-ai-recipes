# Node — OpenImpact sealed (Private / tee)

Verified live 2026-11-13 with `openai` 7.57.0 and with plain `fetch`.

## Option A: openai SDK

```bash
npm install openai
```

```js
import OpenAI from "openai";

const client = new OpenAI({
  baseURL: "https://api.oimpact.ai/v1",
  apiKey: process.env.OPENIMPACT_API_KEY,
});

const resp = await client.chat.completions.create({
  model: "glm-5.3",
  messages: [{ role: "user", content: "Reply with the word OK." }],
  max_tokens: 600,
  // The seal: runs inside a hardware enclave the provider can't read.
  trust_tier: "tee",
});

console.log(resp.choices[0].message.content);
```

## Option B: plain fetch (no dependency)

```js
const r = await fetch("https://api.oimpact.ai/v1/chat/completions", {
  method: "POST",
  headers: {
    Authorization: `Bearer ${process.env.OPENIMPACT_API_KEY}`,
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    model: "glm-5.3",
    trust_tier: "tee",
    messages: [{ role: "user", content: "Reply with the word OK." }],
    max_tokens: 600,
  }),
});
console.log("sealed:", r.headers.get("x-openimpact-trust-tier")); // tee
const data = await r.json();
console.log(data.choices[0].message.content);
```

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
