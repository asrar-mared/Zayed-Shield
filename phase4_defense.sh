#!/bin/bash

# ===========================================
# المرحلة الرابعة: الدفاع الفعال
# Phase 4: Active Defense
# ===========================================

# الألوان
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# المتغيرات
THREAT_COUNTER=${PHASE3_THREATS:-$(cat /tmp/threat_level.tmp 2>/dev/null || echo "0")}
SEVERITY=${PHASE3_SEVERITY:-"unknown"}
LOG_FILE="${LOG_FILE:-/var/log/cyber_shield.log}"
BLOCK_LIST="${BLOCK_LIST:-/tmp/blocked_ips.txt}"
DEFENSE_MODE="standard"

# دالة التسجيل
log_event() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] PHASE4: $1" | tee -a "$LOG_FILE"
}

# دالة التحقق من الصلاحيات
check_permissions() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${YELLOW}⚠️  تحذير: بعض الوظائف تتطلب صلاحيات root${NC}"
        echo -e "${YELLOW}   يرجى تشغيل السكربت بـ sudo للحماية الكاملة${NC}"
        return 1
    fi
    return 0
}

# دالة حظر IP
block_ip() {
    local ip="$1"
    local reason="$2"
    
    # التحقق من صحة عنوان IP - التحقق الشامل
    if [[ ! $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo -e "${RED}  ❌ عنوان IP غير صالح: $ip${NC}"
        return 1
    fi
    
    # التحقق من صحة كل جزء من عنوان IP (0-255)
    local IFS='.'
    read -ra PARTS <<< "$ip"
    for part in "${PARTS[@]}"; do
        if [ "$part" -lt 0 ] || [ "$part" -gt 255 ]; then
            echo -e "${RED}  ❌ عنوان IP غير صالح (قيمة خارج النطاق): $ip${NC}"
            return 1
        fi
    done
    
    # تجنب حظر عناوين محلية مهمة
    if [[ "$ip" == "127.0.0.1" ]] || [[ "$ip" == "0.0.0.0" ]]; then
        echo -e "${YELLOW}  ⚠️  تجاهل حظر العنوان المحلي: $ip${NC}"
        return 1
    fi
    
    # إضافة للقائمة
    echo "$ip|$(date '+%Y-%m-%d %H:%M:%S')|$reason" >> "$BLOCK_LIST"
    
    # حظر باستخدام iptables (إذا كانت الصلاحيات متوفرة)
    if [ "$EUID" -eq 0 ]; then
        iptables -C INPUT -s "$ip" -j DROP 2>/dev/null || \
        iptables -A INPUT -s "$ip" -j DROP 2>/dev/null
        
        iptables -C OUTPUT -d "$ip" -j DROP 2>/dev/null || \
        iptables -A OUTPUT -d "$ip" -j DROP 2>/dev/null
    fi
    
    log_event "IP blocked: $ip - Reason: $reason"
    echo -e "${RED}  🚫 تم حظر: $ip - السبب: $reason${NC}"
    return 0
}

# دالة إيقاف العمليات المشبوهة
kill_suspicious_process() {
    local pid="$1"
    local name="$2"
    
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
        kill -9 "$pid" 2>/dev/null
        log_event "Process killed: $name (PID: $pid)"
        echo -e "${RED}  ⚔️  تم إيقاف العملية: $name (PID: $pid)${NC}"
        return 0
    fi
    return 1
}

# دالة تقييد الخدمات
restrict_service() {
    local service="$1"
    
    if systemctl is-active --quiet "$service" 2>/dev/null; then
        if [ "$EUID" -eq 0 ]; then
            systemctl stop "$service" 2>/dev/null
            log_event "Service stopped: $service"
            echo -e "${YELLOW}  ⏹️  تم إيقاف الخدمة: $service${NC}"
            return 0
        else
            echo -e "${YELLOW}  ⚠️  لا يمكن إيقاف $service بدون صلاحيات root${NC}"
            return 1
        fi
    fi
    return 1
}

# دالة العرض
echo -e "${BLUE}⚔️  المرحلة الرابعة: الدفاع الفعال${NC}"
echo "═══════════════════════════════════════════"

log_event "Active defense phase started - Threat level: $THREAT_COUNTER"

# التحقق من الصلاحيات
check_permissions
HAS_ROOT=$?

# 1. تحديد وضع الدفاع
echo -e "${GREEN}• تحديد وضع الدفاع...${NC}"

if [ "$THREAT_COUNTER" -le 2 ]; then
    DEFENSE_MODE="monitoring"
    echo -e "${CYAN}  📊 الوضع: مراقبة فقط${NC}"
elif [ "$THREAT_COUNTER" -le 5 ]; then
    DEFENSE_MODE="standard"
    echo -e "${YELLOW}  🛡️  الوضع: دفاع قياسي${NC}"
elif [ "$THREAT_COUNTER" -le 10 ]; then
    DEFENSE_MODE="enhanced"
    echo -e "${RED}  ⚔️  الوضع: دفاع معزز${NC}"
else
    DEFENSE_MODE="maximum"
    echo -e "${RED}  💀 الوضع: دفاع أقصى${NC}"
fi

# 2. حظر العناوين المشبوهة
echo -e "${GREEN}• معالجة العناوين المشبوهة...${NC}"

BLOCKED_COUNT=0
if [ -f /tmp/suspicious_ips.tmp ] && [ -s /tmp/suspicious_ips.tmp ]; then
    while read -r ip; do
        if [ -n "$ip" ]; then
            block_ip "$ip" "Suspicious activity detected"
            BLOCKED_COUNT=$((BLOCKED_COUNT + 1))
        fi
    done < /tmp/suspicious_ips.tmp
    echo -e "${CYAN}  📊 تم حظر $BLOCKED_COUNT عنوان IP${NC}"
else
    echo -e "${GREEN}  ✅ لا توجد عناوين مشبوهة للحظر${NC}"
fi

# 3. إيقاف العمليات المشبوهة
echo -e "${GREEN}• معالجة العمليات المشبوهة...${NC}"

KILLED_COUNT=0
if [ -f /tmp/suspicious_processes.tmp ] && [ -s /tmp/suspicious_processes.tmp ]; then
    while read -r process; do
        pid=$(echo "$process" | awk '{print $2}')
        name=$(echo "$process" | awk '{print $11}')
        
        if kill_suspicious_process "$pid" "$name"; then
            KILLED_COUNT=$((KILLED_COUNT + 1))
        fi
    done < /tmp/suspicious_processes.tmp
    echo -e "${CYAN}  📊 تم إيقاف $KILLED_COUNT عملية مشبوهة${NC}"
else
    echo -e "${GREEN}  ✅ لا توجد عمليات مشبوهة للإيقاف${NC}"
fi

# 4. تقييد الخدمات غير الضرورية (في وضع الدفاع المعزز أو الأقصى)
if [ "$DEFENSE_MODE" = "enhanced" ] || [ "$DEFENSE_MODE" = "maximum" ]; then
    echo -e "${GREEN}• تقييد الخدمات غير الضرورية...${NC}"
    
    INSECURE_SERVICES=("telnet" "rsh" "rlogin" "ftp")
    
    for service in "${INSECURE_SERVICES[@]}"; do
        restrict_service "$service"
    done
fi

# 5. تعزيز جدار الحماية (في وضع الدفاع الأقصى)
if [ "$DEFENSE_MODE" = "maximum" ] && [ "$HAS_ROOT" -eq 0 ]; then
    echo -e "${GREEN}• تعزيز جدار الحماية...${NC}"
    
    # حظر الحزم غير الصالحة
    iptables -A INPUT -m conntrack --ctstate INVALID -j DROP 2>/dev/null
    
    # حظر حزم TCP بدون flags
    iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP 2>/dev/null
    
    # حظر هجمات SYN flood
    iptables -A INPUT -p tcp --syn -m limit --limit 1/s --limit-burst 3 -j ACCEPT 2>/dev/null
    
    # حظر فحص المنافذ
    iptables -A INPUT -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j ACCEPT 2>/dev/null
    
    log_event "Firewall rules enhanced"
    echo -e "${RED}  🔥 تم تعزيز قواعد جدار الحماية${NC}"
fi

# 6. إنشاء نقطة استعادة
echo -e "${GREEN}• إنشاء نقطة استعادة...${NC}"

RESTORE_POINT="/tmp/defense_restore_$(date '+%Y%m%d_%H%M%S').sh"
{
    echo "#!/bin/bash"
    echo "# نقطة استعادة - درع زايد"
    echo "# تم إنشاؤها: $(date)"
    echo ""
    echo "# إلغاء حظر العناوين"
    if [ -f "$BLOCK_LIST" ]; then
        while IFS='|' read -r ip _ _; do
            echo "iptables -D INPUT -s $ip -j DROP 2>/dev/null"
            echo "iptables -D OUTPUT -d $ip -j DROP 2>/dev/null"
        done < "$BLOCK_LIST"
    fi
    echo ""
    echo "echo 'تم استعادة الإعدادات السابقة'"
} > "$RESTORE_POINT"
chmod +x "$RESTORE_POINT"

echo -e "${CYAN}  📄 نقطة الاستعادة: $RESTORE_POINT${NC}"

# 7. إنشاء تقرير الدفاع
echo -e "${GREEN}• إنشاء تقرير الدفاع...${NC}"

DEFENSE_REPORT="/tmp/defense_report_$(date '+%Y%m%d_%H%M%S').txt"
{
    echo "═══════════════════════════════════════════════════════"
    echo "🛡️ تقرير الدفاع الفعال - درع زايد"
    echo "═══════════════════════════════════════════════════════"
    echo ""
    echo "📅 التاريخ: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "🔒 وضع الدفاع: $DEFENSE_MODE"
    echo "📊 مستوى التهديد: $THREAT_COUNTER"
    echo ""
    echo "═══════════════════════════════════════════════════════"
    echo "📋 الإجراءات المتخذة"
    echo "═══════════════════════════════════════════════════════"
    echo "• العناوين المحظورة: $BLOCKED_COUNT"
    echo "• العمليات الموقفة: $KILLED_COUNT"
    echo ""
    
    if [ -f "$BLOCK_LIST" ] && [ -s "$BLOCK_LIST" ]; then
        echo "═══════════════════════════════════════════════════════"
        echo "🚫 قائمة العناوين المحظورة"
        echo "═══════════════════════════════════════════════════════"
        cat "$BLOCK_LIST"
    fi
    
    echo ""
    echo "═══════════════════════════════════════════════════════"
    echo "📌 نقطة الاستعادة: $RESTORE_POINT"
    echo "═══════════════════════════════════════════════════════"
} > "$DEFENSE_REPORT"

echo -e "${CYAN}  📄 تقرير الدفاع: $DEFENSE_REPORT${NC}"

# النتيجة النهائية
echo ""
echo "═══════════════════════════════════════════"
case $DEFENSE_MODE in
    monitoring)
        echo -e "${GREEN}✅ المرحلة الرابعة: مراقبة فقط${NC}"
        echo -e "${GREEN}   النظام تحت المراقبة${NC}"
        log_event "Phase 4 completed - Monitoring mode"
        ;;
    standard)
        echo -e "${YELLOW}🛡️  المرحلة الرابعة: دفاع قياسي${NC}"
        echo -e "${YELLOW}   تم تفعيل الحماية الأساسية${NC}"
        log_event "Phase 4 completed - Standard defense"
        ;;
    enhanced)
        echo -e "${RED}⚔️  المرحلة الرابعة: دفاع معزز${NC}"
        echo -e "${RED}   تم تفعيل الحماية المتقدمة${NC}"
        log_event "Phase 4 completed - Enhanced defense"
        ;;
    maximum)
        echo -e "${RED}💀 المرحلة الرابعة: دفاع أقصى${NC}"
        echo -e "${RED}   جميع إجراءات الحماية مفعلة${NC}"
        log_event "Phase 4 completed - Maximum defense"
        ;;
esac

echo -e "${CYAN}📊 ملخص: حظر $BLOCKED_COUNT IP | إيقاف $KILLED_COUNT عملية${NC}"
echo "═══════════════════════════════════════════"

# تصدير النتائج
export PHASE4_MODE="$DEFENSE_MODE"
export PHASE4_BLOCKED="$BLOCKED_COUNT"
export PHASE4_KILLED="$KILLED_COUNT"
exit 0
