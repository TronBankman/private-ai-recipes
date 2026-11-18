#!/usr/bin/env bash
# verify.sh — 10-second check that your OpenImpact key works and requests are sealed.
# Usage:  export OPENIMPACT_API_KEY="<YOUR_KEY>"   then   bash verify.sh
# Needs only curl. Your key is read from the environment and never printed.
set -uo pipefail

API="https://api.oimpact.ai/v1"
MODEL="${OPENIMPACT_MODEL:-glm-5.3}"

if [ -z "${OPENIMPACT_API_KEY:-}" ]; then
  echo "✗ OPENIMPACT_API_KEY is not set."
  echo "  Get a key (\$5 free, no card): https://business.oimpact.ai/?ref=gh-private-ai-recipes"
  echo "  Then run:  export OPENIMPACT_API_KEY=\"<YOUR_KEY>\" && bash verify.sh"
  exit 1
fi

echo "1/2  Checking your key ..."
CODE=$(curl -sS -o /dev/null -w '%{http_code}' "$API/models" \
  -H "Authorization: Bearer $OPENIMPACT_API_KEY" 2>/dev/null || echo 000)
if [ "$CODE" != "200" ]; then
  echo "✗ The key was rejected (HTTP $CODE). Copy it again from business.oimpact.ai → Developers → API keys."
  exit 1
fi
echo "     ✓ key works"

echo "2/2  Sending one sealed request to $MODEL ..."
HEADERS=$(mktemp); BODY=$(mktemp)
trap 'rm -f "$HEADERS" "$BODY"' EXIT
CODE=$(curl -sS -D "$HEADERS" -o "$BODY" -w '%{http_code}' "$API/chat/completions" \
  -H "Authorization: Bearer $OPENIMPACT_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"trust_tier\":\"tee\",\"messages\":[{\"role\":\"user\",\"content\":\"Reply with the word OK.\"}],\"max_tokens\":600}" \
  2>/dev/null || echo 000)
TIER=$(grep -i '^x-openimpact-trust-tier:' "$HEADERS" | tr -d '\r' | awk '{print $2}' || true)

if [ "$CODE" != "200" ]; then
  echo "✗ The request failed (HTTP $CODE):"
  head -c 400 "$BODY"; echo
  exit 1
fi
if [ "$TIER" != "tee" ]; then
  echo "✗ The request ran, but it was not sealed (trust tier: ${TIER:-missing})."
  exit 1
fi

echo "     ✓ sealed: x-openimpact-trust-tier: tee"
echo
echo "PASS — your key works and your requests run inside a hardware enclave the"
echo "model's provider can't read. Next: pick your tool in the README."
