# Anthropic Python SDK — OpenImpact sealed (Private / tee)

Verified live 2026-11-13 with `anthropic` 2.8.0: returned `tee` header and `"OK"`.

## Install

```bash
pip install anthropic
```

## Code

```python
import os
import anthropic

client = anthropic.Anthropic(
    base_url="https://api.oimpact.ai",
    api_key=os.environ["OPENIMPACT_API_KEY"],
)

resp = client.messages.with_raw_response.create(
    model="glm-5.3",
    max_tokens=600,
    messages=[{"role": "user", "content": "Reply with the word OK."}],
    # The seal. Runs inside a hardware enclave; the provider can't read it.
    extra_body={"trust_tier": "tee"},
)

print("sealed:", resp.headers.get("x-openimpact-trust-tier"))  # tee
msg = resp.parse()
print([b.text for b in msg.content if b.type == "text"])
```

## Notes

- `base_url` is `https://api.oimpact.ai` (no `/v1`). The SDK appends `/v1/messages`.
- OpenImpact answers Anthropic-shaped requests with one of its own models; a
  `claude-*` model name on `/v1/messages` is accepted and routed the same way.
- `trust_tier` is OpenImpact-specific, so it goes in `extra_body`.

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
