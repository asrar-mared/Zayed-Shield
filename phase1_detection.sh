#!/bin/bash

# ===========================================
# المرحلة الأولى: التصدي والكشف
# Phase 1: Detection and Response
# ===========================================

# الألوان
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# المتغيرات
THREAT_COUNTER=0
LOG_FILE="${LOG_FILE:-/var/log/cyber_shield.log}"

# دالة التسجيل
log_event() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] PHASE1: $1" | tee -a "$LOG_FILE"
}

# دالة العرض
echo -e "${BLUE}🔍 المرحلة الأولى: التصدي والكشف${NC}"
echo "════════════════════════════════════"

log_event "Detection phase started"

# 1. فحص محاولات الدخول الفاشلة
echo -e "${GREEN}• فحص محاولات الدخول المشبوهة...${NC}"
FAILED_LOGINS=0

if [ -f /var/log/auth.log ]; then
    FAILED_LOGINS=$(tail -n 100 /var/log/auth.log | grep -c "Failed password")
elif [ -f /var/log/secure ]; then
    FAILED_LOGINS=$(tail -n 100 /var/log/secure | grep -c "Failed password")
fi

if [ "$FAILED_LOGINS" -gt 5 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 1))
    echo -e "${YELLOW}  ⚠️  محاولات دخول مشبوهة: $FAILED_LOGINS${NC}"
    log_event "Suspicious login attempts detected: $FAILED_LOGINS"
    
    # استخراج IPs المشبوهة
    if [ -f /var/log/auth.log ]; then
        tail -n 100 /var/log/auth.log | grep "Failed password" | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | sort | uniq > /tmp/suspicious_ips.tmp
    fi
else
    echo -e "${GREEN}  ✅ لا توجد محاولات دخول مشبوهة${NC}"
fi

# 2. فحص الاتصالات النشطة
echo -e "${GREEN}• فحص الاتصالات النشطة...${NC}"
ACTIVE_CONNECTIONS=$(netstat -tuln 2>/dev/null | grep ESTABLISHED | wc -l)
echo -e "${BLUE}  📊 الاتصالات النشطة: $ACTIVE_CONNECTIONS${NC}"

if [ "$ACTIVE_CONNECTIONS" -gt 50 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 1))
    echo -e "${YELLOW}  ⚠️  عدد اتصالات مرتفع${NC}"
    log_event "High number of active connections: $ACTIVE_CONNECTIONS"
fi

# 3. فحص العمليات المشبوهة
echo -e "${GREEN}• فحص العمليات المشبوهة...${NC}"
SUSPICIOUS_PROCESSES=$(ps aux | grep -E "(nc|nmap|hydra|metasploit|nikto)" | grep -v grep | wc -l)

if [ "$SUSPICIOUS_PROCESSES" -gt 0 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 2))
    echo -e "${RED}  🚨 عمليات مشبوهة مكتشفة: $SUSPICIOUS_PROCESSES${NC}"
    log_event "Suspicious processes detected: $SUSPICIOUS_PROCESSES"
    ps aux | grep -E "(nc|nmap|hydra|metasploit|nikto)" | grep -v grep > /tmp/suspicious_processes.tmp
else
    echo -e "${GREEN}  ✅ لا توجد عمليات مشبوهة${NC}"
fi

# 4. فحص المنافذ المفتوحة
echo -e "${GREEN}• فحص المنافذ المفتوحة...${NC}"
OPEN_PORTS=$(netstat -tuln 2>/dev/null | grep LISTEN | wc -l)
echo -e "${BLUE}  📊 المنافذ المفتوحة: $OPEN_PORTS${NC}"

# البحث عن منافذ غير عادية
UNUSUAL_PORTS=$(netstat -tuln 2>/dev/null | grep LISTEN | grep -E ":(1337|31337|4444|5555|6666|7777|8888|9999)" | wc -l)
if [ "$UNUSUAL_PORTS" -gt 0 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 1))
    echo -e "${YELLOW}  ⚠️  منافذ غير عادية مفتوحة: $UNUSUAL_PORTS${NC}"
    log_event "Unusual ports detected: $UNUSUAL_PORTS"
fi

# 5. فحص الملفات المؤقتة المشبوهة
echo -e "${GREEN}• فحص الملفات المؤقتة...${NC}"
TEMP_SUSPICIOUS=$(find /tmp -name "*.php" -o -name "*.exe" -o -name "*.sh" | grep -v "cyber\|shield" | wc -l 2>/dev/null)

if [ "$TEMP_SUSPICIOUS" -gt 0 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 1))
    echo -e "${YELLOW}  ⚠️  ملفات مشبوهة في /tmp: $TEMP_SUSPICIOUS${NC}"
    log_event "Suspicious files in /tmp: $TEMP_SUSPICIOUS"
else
    echo -e "${GREEN}  ✅ مجلد /tmp نظيف${NC}"
fi

# 6. فحص استخدام الذاكرة والمعالج
echo -e "${GREEN}• فحص استخدام الموارد...${NC}"
MEMORY_USAGE=$(free | grep Mem | awk '{printf("%.1f"), $3/$2 * 100.0}')
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf("%.1f", 100 - $1)}')

echo -e "${BLUE}  📊 استخدام الذاكرة: ${MEMORY_USAGE}%${NC}"
echo -e "${BLUE}  📊 استخدام المعالج: ${CPU_USAGE}%${NC}"

if (( $(echo "$MEMORY_USAGE > 85" | bc -l 2>/dev/null || echo "0") )); then
    THREAT_COUNTER=$((THREAT_COUNTER + 1))
    echo -e "${YELLOW}  ⚠️  استخدام ذاكرة مرتفع${NC}"
    log_event "High memory usage: ${MEMORY_USAGE}%"
fi

# حفظ مستوى التهديد للمراحل التالية
echo "$THREAT_COUNTER" > /tmp/threat_level.tmp

# النتيجة النهائية
echo ""
echo "════════════════════════════════════"
if [ "$THREAT_COUNTER" -eq 0 ]; then
    echo -e "${GREEN}✅ المرحلة الأولى: لا توجد تهديدات${NC}"
    log_event "Phase 1 completed - No threats detected"
elif [ "$THREAT_COUNTER" -le 2 ]; then
    echo -e "${YELLOW}⚠️  المرحلة الأولى: تهديدات منخفضة ($THREAT_COUNTER)${NC}"
    log_event "Phase 1 completed - Low threat level: $THREAT_COUNTER"
else
    echo -e "${RED}🚨 المرحلة الأولى: تهديدات عالية ($THREAT_COUNTER)${NC}"
    log_event "Phase 1 completed - High threat level: $THREAT_COUNTER"
fi
echo "════════════════════════════════════"

# تصدير النتائج للمراحل التالية
export PHASE1_THREATS="$THREAT_COUNTER"
exit 0
