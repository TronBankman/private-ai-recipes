# LiteLLM — OpenImpact sealed (Private / tee)

Verified live 2026-11-13 with `litellm`: returned `tee` header and `"OK"`.

LiteLLM is a proxy/router that speaks to many providers behind one OpenAI-style
API. OpenImpact looks like any OpenAI-compatible provider to it.

## As a library

```python
import os
from litellm import completion

resp = completion(
    model="openai/glm-5.3",              # openai/ prefix = OpenAI-compatible
    api_base="https://api.oimpact.ai/v1",
    api_key=os.environ["OPENIMPACT_API_KEY"],
    messages=[{"role": "user", "content": "Reply with the word OK."}],
    max_tokens=600,
    # The seal. extra_body is forwarded to the provider.
    extra_body={"trust_tier": "tee"},
)
print(resp.choices[0].message.content)
```

## As a proxy (config.yaml)

```yaml
model_list:
  - model_name: openimpact-sealed
    litellm_params:
      model: openai/glm-5.3
      api_base: https://api.oimpact.ai/v1
      api_key: os.environ/OPENIMPACT_API_KEY
      extra_body:
        trust_tier: tee
```

Then `litellm --config config.yaml` and call `openimpact-sealed` as the model
name. Every request through that model is sealed.

## Confirm the seal

```python
hdr = (resp._hidden_params.get("additional_headers") or {})
print(hdr.get("llm_provider-x-openimpact-trust-tier"))  # tee
```

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
