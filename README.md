# Private-AI Recipes

Copy-paste setups for pointing open-source AI tools at **OpenImpact**'s
OpenAI- and Anthropic-compatible API, with every request sealed inside a
hardware enclave the provider can't read.

> Why this exists: a lot of teams building on sensitive text — clinic notes,
> legal intake, HR, finance, kids' data — can't send their data to a normal AI
> provider because the provider could read it. OpenImpact's **Private** tier
> runs a request inside a hardware enclave (a TEE), and the model's provider
> cannot read the conversation. If a request can't be sealed, it's refused. This
> works with the standard OpenAI and Anthropic request shapes, so for most tools
> it's a base-URL change plus one extra field.

## What you need

- An OpenImpact workspace and API key. Start with **$5 of free credit, no card**:
  https://business.oimpact.ai/?ref=gh-private-ai-recipes
- A model that runs sealed. `glm-5.3` is the general-purpose one. Run
  `GET /v1/models` to see the current list; models whose `trust_tiers` includes
  `tee` can be sealed.

## How sealing is requested

On every request, send **`trust_tier: "tee"`** (OpenAI shape) or set
**`trust_mode: "private"`**. You can confirm it worked from the response header
`x-openimpact-trust-tier: tee`. If you instead set your whole workspace to
Private in Settings, every call on your API keys is sealed automatically — but
sending the field on the request is the belt-and-braces version and is what the
recipes below do.

## Recipes

| Tool | Recipe | Shape |
|------|--------|-------|
| curl | [recipes/curl.md](recipes/curl.md) | OpenAI |
| OpenAI Python SDK | [recipes/openai-python.md](recipes/openai-python.md) | OpenAI |
| Anthropic Python SDK | [recipes/anthropic-python.md](recipes/anthropic-python.md) | Anthropic |
| Node (fetch / openai SDK) | [recipes/node.md](recipes/node.md) | OpenAI |
| Claude Code | [recipes/claude-code.md](recipes/claude-code.md) | Anthropic |
| LiteLLM | [recipes/litellm.md](recipes/litellm.md) | OpenAI |
| OpenCode | [recipes/opencode.md](recipes/opencode.md) | OpenAI |
| Cherry Studio | [recipes/cherry-studio.md](recipes/cherry-studio.md) | OpenAI |
| Jan | [recipes/jan.md](recipes/jan.md) | OpenAI |
| Continue | [recipes/continue.md](recipes/continue.md) | OpenAI |
| Cline | [recipes/cline.md](recipes/cline.md) | OpenAI |
| LibreChat | [recipes/librechat.md](recipes/librechat.md) | OpenAI |
| Open WebUI | [recipes/open-webui.md](recipes/open-webui.md) | OpenAI |

Each recipe was run live against `api.oimpact.ai` with a real key read from the
environment, and the `x-openimpact-trust-tier: tee` header confirmed, before it
was added here. The key is never written into any file in this repo — every
recipe uses `$OPENIMPACT_API_KEY` or `<YOUR_KEY>`.

## Pricing (public)

- **$5 free credit**, no card.
- **Solo**: $30/month for one agent, $15/month for each extra agent.
- **Business**: $150/month with 20 agents included.
- You're billed what the model provider actually charged, plus OpenImpact's
  markup. Sealed (`tee`) requests cost more than verified-tier requests because
  the enclave is real hardware.

## Disclosure

This repo is maintained by OpenImpact's AI agent on behalf of the OpenImpact
team. Everything in it is
a setup guide using only public facts from https://business.oimpact.ai and the
public API. If a recipe is wrong or a tool has changed, open an issue or PR.
