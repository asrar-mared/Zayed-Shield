#!/bin/bash

# ===========================================
# المرحلة الثانية: المراقبة المتقدمة
# Phase 2: Advanced Monitoring
# ===========================================

# الألوان
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# المتغيرات
THREAT_COUNTER=${PHASE1_THREATS:-$(cat /tmp/threat_level.tmp 2>/dev/null || echo "0")}
LOG_FILE="${LOG_FILE:-/var/log/cyber_shield.log}"

# دالة التسجيل
log_event() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] PHASE2: $1" | tee -a "$LOG_FILE"
}

# دالة العرض
echo -e "${BLUE}📊 المرحلة الثانية: المراقبة المتقدمة${NC}"
echo "═══════════════════════════════════════"

log_event "Advanced monitoring phase started"

# 1. تحليل حركة الشبكة
echo -e "${GREEN}• تحليل حركة الشبكة...${NC}"

# فحص اتصالات SSH
SSH_CONNECTIONS=$(ss -tuln 2>/dev/null | grep :22 | wc -l)
echo -e "${BLUE}  📡 اتصالات SSH: $SSH_CONNECTIONS${NC}"

# فحص اتصالات HTTP/HTTPS
HTTP_CONNECTIONS=$(ss -tuln 2>/dev/null | grep -E ":(80|443|8080|8443)" | wc -l)
echo -e "${BLUE}  🌐 اتصالات HTTP/HTTPS: $HTTP_CONNECTIONS${NC}"

# فحص الاتصالات الخارجية المشبوهة
SUSPICIOUS_OUTBOUND=$(netstat -tuln 2>/dev/null | grep ESTABLISHED | grep -E ":(1337|31337|4444|5555|6666|7777|8888|9999)" | wc -l)
if [ "$SUSPICIOUS_OUTBOUND" -gt 0 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 2))
    echo -e "${RED}  🚨 اتصالات خارجية مشبوهة: $SUSPICIOUS_OUTBOUND${NC}"
    log_event "Suspicious outbound connections detected: $SUSPICIOUS_OUTBOUND"
fi

# 2. مراقبة استخدام النطاق الترددي
echo -e "${GREEN}• مراقبة النطاق الترددي...${NC}"

# فحص الواجهات النشطة
ACTIVE_INTERFACES=$(ip link show | grep "state UP" | wc -l)
echo -e "${BLUE}  🔗 الواجهات النشطة: $ACTIVE_INTERFACES${NC}"

# تحليل إحصائيات الشبكة
if [ -f /proc/net/dev ]; then
    HIGH_TRAFFIC_INTERFACES=$(awk 'NR>2 {if($2 > 1000000000 || $10 > 1000000000) print $1}' /proc/net/dev | wc -l)
    if [ "$HIGH_TRAFFIC_INTERFACES" -gt 0 ]; then
        echo -e "${YELLOW}  ⚠️  واجهات بحركة مرور عالية: $HIGH_TRAFFIC_INTERFACES${NC}"
        THREAT_COUNTER=$((THREAT_COUNTER + 1))
        log_event "High traffic detected on $HIGH_TRAFFIC_INTERFACES interfaces"
    fi
fi

# 3. تحليل ملفات السجل المتقدم
echo -e "${GREEN}• تحليل السجلات المتقدم...${NC}"

# فحص سجلات النظام
SYSTEM_ERRORS=0
if [ -f /var/log/syslog ]; then
    SYSTEM_ERRORS=$(tail -n 200 /var/log/syslog | grep -c -i "error\|critical\|fatal")
elif [ -f /var/log/messages ]; then
    SYSTEM_ERRORS=$(tail -n 200 /var/log/messages | grep -c -i "error\|critical\|fatal")
fi

echo -e "${BLUE}  📋 أخطاء النظام: $SYSTEM_ERRORS${NC}"
if [ "$SYSTEM_ERRORS" -gt 10 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 1))
    echo -e "${YELLOW}  ⚠️  عدد أخطاء مرتفع في النظام${NC}"
    log_event "High system error count: $SYSTEM_ERRORS"
fi

# فحص محاولات الوصول المرفوضة
ACCESS_DENIED=0
if [ -f /var/log/auth.log ]; then
    ACCESS_DENIED=$(tail -n 100 /var/log/auth.log | grep -c -i "denied\|refused\|invalid")
elif [ -f /var/log/secure ]; then
    ACCESS_DENIED=$(tail -n 100 /var/log/secure | grep -c -i "denied\|refused\|invalid")
fi

echo -e "${BLUE}  🚫 محاولات وصول مرفوضة: $ACCESS_DENIED${NC}"
if [ "$ACCESS_DENIED" -gt 5 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 1))
    echo -e "${YELLOW}  ⚠️  محاولات وصول مرفوضة متعددة${NC}"
    log_event "Multiple access denied attempts: $ACCESS_DENIED"
fi

# 4. فحص التطبيقات والخدمات
echo -e "${GREEN}• فحص الخدمات والتطبيقات...${NC}"

# فحص الخدمات النشطة
RUNNING_SERVICES=$(systemctl list-units --type=service --state=running | grep -c "running")
echo -e "${BLUE}  🔧 الخدمات النشطة: $RUNNING_SERVICES${NC}"

# فحص الخدمات المشبوهة
SUSPICIOUS_SERVICES=$(systemctl list-units --type=service --state=running | grep -E -c "(nc|netcat|backdoor|shell|reverse)")
if [ "$SUSPICIOUS_SERVICES" -gt 0 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 2))
    echo -e "${RED}  🚨 خدمات مشبوهة: $SUSPICIOUS_SERVICES${NC}"
    log_event "Suspicious services detected: $SUSPICIOUS_SERVICES"
fi

# 5. مراقبة تغيرات الملفات المهمة
echo -e "${GREEN}• مراقبة الملفات الحساسة...${NC}"

# فحص آخر تعديل على ملفات النظام المهمة
CRITICAL_FILES=("/etc/passwd" "/etc/shadow" "/etc/sudoers" "/etc/hosts")
RECENT_CHANGES=0

for file in "${CRITICAL_FILES[@]}"; do
    if [ -f "$file" ]; then
        # فحص إذا تم تعديل الملف في آخر ساعة
        if [ "$(find "$file" -mmin -60 2>/dev/null | wc -l)" -gt 0 ]; then
            RECENT_CHANGES=$((RECENT_CHANGES + 1))
            echo -e "${YELLOW}  ⚠️  تم تعديل: $file${NC}"
        fi
    fi
done

if [ "$RECENT_CHANGES" -gt 0 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 2))
    echo -e "${RED}  🚨 تعديلات حديثة على ملفات حساسة: $RECENT_CHANGES${NC}"
    log_event "Recent changes to critical files: $RECENT_CHANGES"
else
    echo -e "${GREEN}  ✅ الملفات الحساسة لم تتغير${NC}"
fi

# 6. تحليل DNS والشبكة
echo -e "${GREEN}• تحليل طلبات DNS...${NC}"

# فحص طلبات DNS المشبوهة
DNS_QUERIES=0
if [ -f /var/log/syslog ]; then
    DNS_QUERIES=$(tail -n 100 /var/log/syslog | grep -c -i "dns")
fi

echo -e "${BLUE}  🌐 طلبات DNS: $DNS_QUERIES${NC}"

# فحص طلبات DNS لدومينات مشبوهة
MALICIOUS_DNS=$(tail -n 100 /var/log/syslog 2>/dev/null | grep -E -c -i "(malware|phishing|botnet|trojan|virus)")
if [ "$MALICIOUS_DNS" -gt 0 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 3))
    echo -e "${RED}  🚨 طلبات DNS مشبوهة: $MALICIOUS_DNS${NC}"
    log_event "Malicious DNS queries detected: $MALICIOUS_DNS"
fi

# 7. فحص أداء النظام المتقدم
echo -e "${GREEN}• تحليل أداء النظام...${NC}"

# فحص العمليات التي تستهلك موارد عالية
HIGH_CPU_PROCESSES=$(ps aux --sort=-%cpu | head -6 | tail -n +2 | awk '$3 > 20' | wc -l)
HIGH_MEM_PROCESSES=$(ps aux --sort=-%mem | head -6 | tail -n +2 | awk '$4 > 20' | wc -l)

echo -e "${BLUE}  💻 عمليات عالية CPU: $HIGH_CPU_PROCESSES${NC}"
echo -e "${BLUE}  🧠 عمليات عالية الذاكرة: $HIGH_MEM_PROCESSES${NC}"

if [ "$HIGH_CPU_PROCESSES" -gt 2 ] || [ "$HIGH_MEM_PROCESSES" -gt 2 ]; then
    THREAT_COUNTER=$((THREAT_COUNTER + 1))
    echo -e "${YELLOW}  ⚠️  عمليات تستهلك موارد عالية${NC}"
    log_event "High resource consumption processes detected"
fi

# تحديث مستوى التهديد
echo "$THREAT_COUNTER" > /tmp/threat_level.tmp

# النتيجة النهائية
echo ""
echo "═══════════════════════════════════════"
if [ "$THREAT_COUNTER" -le 2 ]; then
    echo -e "${GREEN}✅ المرحلة الثانية: مستوى تهديد منخفض ($THREAT_COUNTER)${NC}"
    log_event "Phase 2 completed - Low threat level: $THREAT_COUNTER"
elif [ "$THREAT_COUNTER" -le 5 ]; then
    echo -e "${YELLOW}⚠️  المرحلة الثانية: مستوى تهديد متوسط ($THREAT_COUNTER)${NC}"
    log_event "Phase 2 completed - Medium threat level: $THREAT_COUNTER"
else
    echo -e "${RED}🚨 المرحلة الثانية: مستوى تهديد عالي ($THREAT_COUNTER)${NC}"
    log_event "Phase 2 completed - High threat level: $THREAT_COUNTER"
fi
echo "═══════════════════════════════════════"

# تصدير النتائج للمراحل التالية
export PHASE2_THREATS="$THREAT_COUNTER"
exit 0
