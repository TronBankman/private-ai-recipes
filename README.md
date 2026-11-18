# Private-AI Recipes

**Use AI on data you can't send to a normal AI provider** — clinic notes,
legal intake, HR files, finance, kids' data — without the model's provider
being able to read it.

OpenImpact runs each request inside a **hardware enclave** (a TEE) that the
model's provider can't see into. If a request can't be sealed, it's refused
rather than sent another way. It speaks the standard OpenAI and Anthropic
formats, so for most tools switching is a base-URL change and one setting.

This repo has copy-paste setups for 15 tools, plus a 10-second check script.

## Start in 3 steps

**1. Get a key** — $5 of free credit, no card:
https://business.oimpact.ai/?ref=gh-private-ai-recipes
(Developers → API keys → Create key)

**2. Check it works and is sealed:**

```bash
export OPENIMPACT_API_KEY="<YOUR_KEY>"
curl -sO https://raw.githubusercontent.com/TronBankman/private-ai-recipes/main/verify.sh
bash verify.sh
```

You should see:

```
     ✓ key works
     ✓ sealed: x-openimpact-trust-tier: tee
PASS — your key works and your requests run inside a hardware enclave ...
```

**3. Pick your tool below** and copy its setup.

## Recipes

| Tool | Setup | Status |
|------|-------|--------|
| curl | [recipes/curl.md](recipes/curl.md) | ✅ Tested live |
| OpenAI Python SDK | [recipes/openai-python.md](recipes/openai-python.md) | ✅ Tested live |
| Anthropic Python SDK | [recipes/anthropic-python.md](recipes/anthropic-python.md) | ✅ Tested live |
| Node (`openai` SDK / fetch) | [recipes/node.md](recipes/node.md) | ✅ Tested live |
| LiteLLM | [recipes/litellm.md](recipes/litellm.md) | ✅ Tested live |
| OpenCode | [recipes/opencode.md](recipes/opencode.md) | ✅ Tested live in OpenCode |
| Aider | [recipes/aider.md](recipes/aider.md) | ✅ Aider's request tested live |
| Continue | [recipes/continue.md](recipes/continue.md) | 📄 Setup checked, not run yet |
| Cline | [recipes/cline.md](recipes/cline.md) | 📄 Setup checked, not run yet |
| Cursor | [recipes/cursor.md](recipes/cursor.md) | 📄 Not run yet — read the note on Cursor's servers |
| Cherry Studio | [recipes/cherry-studio.md](recipes/cherry-studio.md) | 📄 Setup checked, not run yet |
| Jan | [recipes/jan.md](recipes/jan.md) | 📄 Setup checked, not run yet |
| LibreChat | [recipes/librechat.md](recipes/librechat.md) | 📄 Setup checked, not run yet |
| Open WebUI | [recipes/open-webui.md](recipes/open-webui.md) | 📄 Setup checked, not run yet |
| Claude Code | [recipes/claude-code.md](recipes/claude-code.md) | ⚠️ Not working yet — use OpenCode or Aider for now |

**✅ Tested live** means the setup was run against `api.oimpact.ai` with a real
key and came back sealed (`x-openimpact-trust-tier: tee`). **📄 Setup checked**
means it follows the tool's own docs and source but hasn't been run end-to-end
yet. Tried one? Open an issue with what happened and we'll update the table.

## How sealing works

- **Easiest:** set your workspace to **Private** in Settings → Privacy level on
  business.oimpact.ai. Every call on your API keys is then sealed, whatever tool
  you use.
- **Per request:** send `"trust_tier": "tee"` in the request body. The recipes
  show where each tool lets you add it.
- **Proof:** every sealed response carries the header
  `x-openimpact-trust-tier: tee`.

Sealed models today include `glm-5.3` (general purpose). For the current list,
call `GET /v1/models` — models whose `trust_tiers` include `tee` can be sealed.

## Pricing (public)

- **$5 free credit**, no card.
- **Solo**: $30/month for one agent, $15/month for each extra agent.
- **Business**: $150/month with 20 agents included.
- You're billed what the model provider actually charged, plus OpenImpact's
  markup. Per-model prices are listed by `GET /v1/models`.

## Your key stays yours

No file in this repo contains a key. Every recipe reads it from
`$OPENIMPACT_API_KEY` or shows `<YOUR_KEY>`, and `verify.sh` never prints it.

## Disclosure

This repo is maintained by OpenImpact's AI agent on behalf of the OpenImpact
team. Everything in it uses only public facts from https://business.oimpact.ai
and the public API. If a recipe is wrong or a tool has changed, open an issue
or PR.
