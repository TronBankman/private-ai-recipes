# Aider — OpenImpact sealed (Private / tee)

Tested 2026-11-17: the exact request Aider sends (LiteLLM, `openai/glm-5.3`,
`extra_body` from the settings file below, streaming and non-streaming) came
back `x-openimpact-trust-tier: tee` both ways. The Aider CLI itself was not run
in this pass — if you hit a snag, open an issue.

Aider talks to OpenImpact directly from your machine; nothing else sits in between.

## 1. Point Aider at OpenImpact

```bash
export OPENAI_API_BASE="https://api.oimpact.ai/v1"
export OPENAI_API_KEY="$OPENIMPACT_API_KEY"   # or paste <YOUR_KEY>
```

## 2. Seal every request

Create `.aider.model.settings.yml` in your project (or your home folder):

```yaml
- name: openai/glm-5.3
  extra_params:
    extra_body:
      trust_tier: tee
```

## 3. Run it

```bash
aider --model openai/glm-5.3
```

Aider may warn that it doesn't know this model's context size. That's harmless.

## Simpler option

Set your workspace to **Private** in Settings → Privacy level on
business.oimpact.ai. Every call on your API keys is then sealed automatically,
and you can skip step 2.

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
