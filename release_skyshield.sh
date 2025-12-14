#!/bin/bash

# ============================================================================
# سكربت سيادي لإطلاق أي إصدار GitHub - SkyShield Ceremonial Release
# ============================================================================

VERSION="$1"
DESCRIPTION="$2"
IMAGE_FILE="${3:-}"

if [[ -z "$VERSION" || -z "$DESCRIPTION" ]]; then
  echo "❌ الاستخدام: ./release_skyshield.sh vX.Y.Z \"وصف الإصدار\" [صورة_اختيارية.jpg]"
  exit 1
fi

echo "🚀 إطلاق الإصدار السيادي: $VERSION"
echo "📝 الوصف: $DESCRIPTION"

# 1. تحقق من وجود التاج
if git rev-parse "$VERSION" >/dev/null 2>&1; then
  echo "✅ التاج $VERSION موجود بالفعل"
else
  git tag -a "$VERSION" -m "$DESCRIPTION"
  echo "🏷️ تم إنشاء التاج $VERSION"
fi

# 2. دفع التاج
git push origin "$VERSION"

# 3. توليد سجل تغييرات
CHANGELOG_FILE="CHANGELOG.md"
DATE=$(date +"%Y-%m-%d")
{
  echo "## $VERSION – $DATE"
  echo ""
  echo "$DESCRIPTION"
  echo ""
  echo "---"
} >> "$CHANGELOG_FILE"

# 4. إنشاء الإصدار عبر GitHub CLI
gh release create "$VERSION" \
  --title "$VERSION" \
  --notes "$DESCRIPTION" \
  --verify-tag

# 5. إرفاق صورة إذا وُجدت
if [[ -n "$IMAGE_FILE" && -f "$IMAGE_FILE" ]]; then
  gh release upload "$VERSION" "$IMAGE_FILE"
  echo "🖼️ تم إرفاق الصورة: $IMAGE_FILE"
fi

echo "✅ تم إطلاق الإصدار السيادي $VERSION بنجاح!"
