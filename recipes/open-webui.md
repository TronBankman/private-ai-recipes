# Open WebUI — OpenImpact sealed (Private / tee)

Config-shape verified 2026-11-13 against `open-webui/open-webui`
(OpenAI-compatible connection via Admin Settings). Not run end-to-end against
Open WebUI in this pass.

## In Admin Settings → Connections

1. Open WebUI → Admin Panel → Settings → Connections.
2. Add an OpenAI API connection:
   - **Base URL**: `https://api.oimpact.ai/v1`
   - **API Key**: your key
3. Save, then fetch models and pick `glm-5.3`.

## Sealing every request

Set your **workspace to Private** in Settings → Privacy level on
business.oimpact.ai. Once Private, every call on your API keys runs inside the
hardware enclave automatically — the provider can't read it.

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
