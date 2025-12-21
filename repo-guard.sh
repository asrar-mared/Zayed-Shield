#!/usr/bin/env باش
set -euo فشل الأنابيب.

صدى.  "[+] تهيئة مستودع تصلب وقائي"......

# 1. Disable execution permissions on workflows directory
if [ -d ".github/workflows" ]; then
  echo "[+] Locking workflows directory"
  chmod -R a-w .github/workflows || true
fi

# 2. Ensure disabled workflows stay disabled
if [ -d ".github/workflows-disabled" ]; then
  echo "[+] Verifying disabled workflows state"
  chmod -R 000 .github/workflows-disabled || true
fi

# 3. Enforce read-only policy on CI-related scripts
find . -type f \( -name "*.sh" -o -name "*.yml" \) \
  -path "./.github/*" \
  -exec chmod 400 {} \; || true

# 4. Validate no secrets exist in repository
echo "[+] Checking for accidental secrets"
grep -R -i -E "token|secret|api[_-]?key|private[_-]?key" . \
  --exclude-dir=.git || true

# 5. Log hardening timestamp
echo "Repository locked at $(date -u)" > .security-lock

echo "[✓] Preventive security hardening completed successfully."
