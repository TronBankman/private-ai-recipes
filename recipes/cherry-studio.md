# Cherry Studio — OpenImpact sealed (Private / tee)

Config-shape verified 2026-11-13 against `CherryHQ/cherry-studio` source
(custom OpenAI provider takes a base URL and API key). Not run end-to-end
against Cherry Studio in this pass.

## In the app

1. Settings → Model Service → Add Provider (or "OpenAI-compatible").
2. Set:
   - **API host / Base URL**: `https://api.oimpact.ai/v1`
   - **API Key**: your key (or `${OPENIMPACT_API_KEY}`)
3. Add model `glm-5.3`.

## Sealing every request

Set your **workspace to Private** in Settings → Privacy level on
business.oimpact.ai. Once Private, every call on your API keys runs inside the
hardware enclave automatically — the provider can't read it.

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
