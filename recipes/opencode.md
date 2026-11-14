# OpenCode — OpenImpact sealed (Private / tee)

Config-shape verified 2026-11-13 against `sst/opencode` source (provider type
`openai-compatible` takes `baseURL` + `apiKey`). Not run end-to-end against the
OpenCode CLI in this pass — if you hit a snag, open an issue.

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

If you want the seal on the request itself, OpenCode forwards provider options —
check the OpenCode docs for the current `providerOptions` key and add
`{ "trust_tier": "tee" }` there. The Private-workspace setting is the simpler
guarantee.

```bash
export OPENIMPACT_API_KEY="<YOUR_KEY>"
opencode --model openimpact/glm-5.3
```

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
