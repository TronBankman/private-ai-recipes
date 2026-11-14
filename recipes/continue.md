# Continue — OpenImpact sealed (Private / tee)

Config-shape verified 2026-11-13 against `continuedev/continue` source
(`models` entry with `apiBase` + `apiKey`). Not run end-to-end against Continue
in this pass.

## `~/.continue/config.json`

```json
{
  "models": [
    {
      "title": "OpenImpact sealed",
      "provider": "openai",
      "model": "glm-5.3",
      "apiBase": "https://api.oimpact.ai/v1",
      "apiKey": "{OPENIMPACT_API_KEY}"
    }
  ]
}
```

## Sealing every request

Set your **workspace to Private** in Settings → Privacy level on
business.oimpact.ai. Once Private, every call on your API keys runs inside the
hardware enclave automatically — the provider can't read it.

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
