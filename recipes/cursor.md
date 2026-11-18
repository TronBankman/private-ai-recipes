# Cursor — OpenImpact (Private workspace)

Not yet tested end-to-end in Cursor. Steps follow Cursor's own custom-key
settings. If you hit a snag, open an issue.

## Read this first

- **Cursor routes custom-key requests through Cursor's own servers** before they
  reach OpenImpact. OpenImpact's enclave keeps the model's provider from reading
  your prompts, but Cursor's servers still handle them. If that isn't
  acceptable for your data, use a tool that connects directly from your
  machine: [Continue](continue.md), [Cline](cline.md), [OpenCode](opencode.md)
  or [Aider](aider.md).
- Cursor can't add OpenImpact's `trust_tier` field to a request, so sealing
  comes from your **workspace setting** (step 1).
- Cursor's Tab autocomplete always uses Cursor's own model, and Agent mode
  doesn't use custom keys.

## 1. Make your workspace Private

On business.oimpact.ai, go to Settings → Privacy level and choose **Private**.
Every call on your API keys is then sealed automatically.

## 2. Add OpenImpact in Cursor

Cursor Settings → Models:

1. Under **API Keys**, turn on **OpenAI API Key** and paste your OpenImpact key.
2. Turn on **Override OpenAI Base URL** and enter `https://api.oimpact.ai/v1`.
3. Click **+ Add Custom Model**, enter `glm-5.3`, and switch it on.

While the base-URL override is on, Cursor may send its other OpenAI-model
requests to OpenImpact too. Turn it off when you go back to Cursor's own models.

## 3. Check it's sealed

Run `bash verify.sh` from this repo with the same key. With a Private
workspace, the result should say **sealed**.

Get a key and $5 free credit: https://business.oimpact.ai/?ref=gh-private-ai-recipes
