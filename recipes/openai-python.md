# OpenAI Python SDK — OpenImpact sealed (Private / tee)

Verified live 2026-11-13 with `openai` 3.51.0: returned `tee` header and `"OK"`.

## Install

```bash
pip install openai
```

## Code

```python
import os
from openai import OpenAI

client = OpenAI(
    base_url="https://api.oimpact.ai/v1",
    api_key=os.environ["OPENIMPACT_API_KEY"],
)

resp = client.chat.completions.with_raw_response.create(
    model="glm-5.3",
    messages=[{"role": "user", "content": "Reply with the word OK."}],
    max_tokens=600,
    # The seal. OpenImpact runs this inside a hardware enclave; the provider
    # can't read it. If it can't be sealed, the request is refused.
    extra_body={"trust_tier": "tee"},
)

print("sealed:", resp.headers.get("x-openimpact-trust-tier"))  # tee
msg = resp.parse()
print(msg.choices[0].message.content)
```

`extra_body` is the SDK's way of adding a field that isn't in its typed schema;
`trust_tier` is OpenImpact-specific, so it goes there.

## Why `extra_body`

The OpenAI SDK validates known fields. `trust_tier` is an OpenImpact field, so
it must go in `extra_body` rather than the top-level call.

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
