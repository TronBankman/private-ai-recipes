# LibreChat — OpenImpact sealed (Private / tee)

Config-shape verified 2026-11-13 against `danny-avila/LibreChat`
(custom OpenAI endpoint via `ENDPOINTS` + `openAI.baseURL`). Not run end-to-end
against LibreChat in this pass.

## `librechat.yaml`

```yaml
version: 1.2.1
cache: true
endpoints:
  custom:
    - name: OpenImpact
      apiKey: ${OPENIMPACT_API_KEY}
      baseURL: https://api.oimpact.ai/v1
      models:
        default: ["glm-5.3"]
      titleConvo: true
      titleModel: "glm-5.3"
```

## Sealing every request

Set your **workspace to Private** in Settings → Privacy level on
business.oimpact.ai. Once Private, every call on your API keys runs inside the
hardware enclave automatically — the provider can't read it.

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
