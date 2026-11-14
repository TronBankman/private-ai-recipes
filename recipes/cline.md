# Cline — OpenImpact sealed (Private / tee)

Config-shape verified 2026-11-13 against `cline/cline` source (API provider
with base URL + key). Not run end-to-end against Cline in this pass.

## In the VS Code extension

1. Open Cline → settings (gear).
2. API Provider: **OpenAI Compatible**.
3. Set:
   - **Base URL**: `https://api.oimpact.ai/v1`
   - **API Key**: your key
   - **Model**: `glm-5.3`

## Sealing every request

Set your **workspace to Private** in Settings → Privacy level on
business.oimpact.ai. Once Private, every call on your API keys runs inside the
hardware enclave automatically — the provider can't read it.

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
