# curl — OpenImpact sealed (Private / tee)

Verified live 2026-11-13: HTTP 200, response header `x-openimpact-trust-tier: tee`.

## Set your key

```bash
export OPENIMPACT_API_KEY="<YOUR_KEY>"
```

## OpenAI-compatible request, sealed

```bash
curl https://api.oimpact.ai/v1/chat/completions \
  -H "Authorization: Bearer $OPENIMPACT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "glm-5.3",
    "trust_tier": "tee",
    "messages": [{"role": "user", "content": "Reply with the word OK."}],
    "max_tokens": 600
  }'
```

The important part is `"trust_tier": "tee"`. That tells OpenImpact to run the
request inside a hardware enclave, and the model's provider cannot read the
conversation. If it can't be sealed, the request is refused.

## Confirm it was sealed

Add `-D -` to see headers:

```bash
curl -s -D - https://api.oimpact.ai/v1/chat/completions \
  -H "Authorization: Bearer $OPENIMPACT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"glm-5.3","trust_tier":"tee","messages":[{"role":"user","content":"hi"}],"max_tokens":50}' \
  | grep -i 'x-openimpact-trust-tier'
# expect: x-openimpact-trust-tier: tee
```

## Anthropic-compatible shape (for tools that send Anthropic requests)

Same base host, endpoint `/v1/messages`, header `x-api-key` instead of Bearer:

```bash
curl https://api.oimpact.ai/v1/messages \
  -H "x-api-key: $OPENIMPACT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "glm-5.3",
    "trust_tier": "tee",
    "max_tokens": 600,
    "messages": [{"role": "user", "content": "Reply with the word OK."}]
  }'
```

## List sealed models

```bash
curl https://api.oimpact.ai/v1/models -H "Authorization: Bearer $OPENIMPACT_API_KEY"
# each model lists trust_tiers; "tee" means it can be sealed
```

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
