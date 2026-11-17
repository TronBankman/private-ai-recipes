# OpenCode — OpenImpact sealed (Private / tee)

Live tested 2026-11-16 with OpenCode 1.19.5 (`opencode run`): the config below
answered end-to-end, and with the per-model `trust_tier` option every request
came back `x-openimpact-trust-tier: tee`. If you hit a snag, open an issue.

## `opencode.json` (project) or `~/.config/opencode/opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "openimpact": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "OpenImpact (sealed)",
      "options": {
        "baseURL": "https://api.oimpact.ai/v1",
        "apiKey": "{env:OPENIMPACT_API_KEY}"
      },
      "models": {
        "glm-5.3": { "name": "GLM-5.3 (sealed)" }
      }
    }
  }
}
```

## Sealing every request

`trust_tier` is an OpenImpact field, not an OpenCode setting. The reliable way
to seal every request is to set your **workspace to Private** in Settings →
Privacy level on business.oimpact.ai. Once the workspace is Private, every call
on your API keys is made inside the hardware enclave automatically.

To put the seal on the request itself, add `trust_tier` to the model's
`options` — OpenCode sends it in the request body:

```json
"models": {
  "glm-5.3": { "name": "GLM-5.3 (sealed)", "options": { "trust_tier": "tee" } }
}
```

The Private-workspace setting is still the simpler guarantee.

```bash
export OPENIMPACT_API_KEY="<YOUR_KEY>"
opencode --model openimpact/glm-5.3
```

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
