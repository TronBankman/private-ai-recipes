# Claude Code — OpenImpact sealed (Private / tee)

Claude Code speaks the Anthropic API. Point it at OpenImpact's
Anthropic-compatible endpoint and, with a Private workspace, every request runs
in a sealed enclave.

The endpoint was verified live 2026-11-13 (Anthropic SDK, `tee` header). The
Claude Code CLI itself was not run end-to-end in this pass.

## Setup

```bash
export ANTHROPIC_BASE_URL="https://api.oimpact.ai"
export ANTHROPIC_API_KEY="<YOUR_KEY>"
export ANTHROPIC_MODEL="glm-5.3"
# Ask for a sealed request on every call.
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5.3"
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-5.3"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-5.3"
```

Then run `claude` as usual.

## Forcing the seal

`trust_tier` is an OpenImpact field, not a Claude Code setting, so the reliable
way to seal every request is to set your **workspace to Private** in
Settings → Privacy level on business.oimpact.ai. Once the workspace is Private,
every call on your API keys is made inside the hardware enclave automatically —
chats, API requests, training and daily runs alike.

> From the public docs: "Choose Private in Settings and your whole workspace is
> sealed: chats in the workspace, on your hosted page, website chat, Telegram
> and Discord, requests on your API keys… are all made inside a hardware
> enclave, so the model's provider can't read them."

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
