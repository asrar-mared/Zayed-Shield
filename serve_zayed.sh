#!/data/data/com.termux/files/usr/bin/bash

# ⚔️ Zayed Shield Serve Script ⚔️

PORT=5000
echo "🔄 Starting Zayed-Shield on port $PORT..."

# تشغيل الخادم على المنفذ المحدد
npx serve -l $PORT dist &

# الانتظار لحظة للتأكد من تشغيل الخادم
sleep 2

# فتح الرابط في Google Chrome
am start -a android.intent.action.VIEW -d "http://localhost:$PORT" com.android.chrome
