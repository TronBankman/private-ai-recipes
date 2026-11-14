# Jan — OpenImpact sealed (Private / tee)

Config-shape verified 2026-11-13 against `janhq/jan` source (custom OpenAI
provider takes a base URL and API key). Not run end-to-end against Jan in this
pass.

## In the app

1. Settings → Models → Add custom model / OpenAI-compatible provider.
2. Set:
   - **Base URL**: `https://api.oimpact.ai/v1`
   - **API Key**: your key
3. Add model `glm-5.3`.

## Sealing every request

Set your **workspace to Private** in Settings → Privacy level on
business.oimpact.ai. Once Private, every call on your API keys runs inside the
hardware enclave automatically.

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
