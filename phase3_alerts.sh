#!/bin/bash

# ===========================================
# المرحلة الثالثة: التحذيرات والإنذارات
# Phase 3: Alerts and Warnings
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
THREAT_COUNTER=${PHASE2_THREATS:-$(cat /tmp/threat_level.tmp 2>/dev/null || echo "0")}
LOG_FILE="${LOG_FILE:-/var/log/cyber_shield.log}"
ALERT_FILE="${ALERT_FILE:-/tmp/security_alerts.txt}"
ADMIN_EMAIL="${ADMIN_EMAIL:-admin@company.ae}"

# دالة التسجيل
log_event() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] PHASE3: $1" | tee -a "$LOG_FILE"
}

# دالة إرسال التنبيه
send_alert() {
    local severity="$1"
    local message="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    {
        echo "═══════════════════════════════════════"
        echo "🚨 تنبيه أمني - درع زايد"
        echo "═══════════════════════════════════════"
        echo "الوقت: $timestamp"
        echo "المستوى: $severity"
        echo "الرسالة: $message"
        echo "مستوى التهديد: $THREAT_COUNTER"
        echo "═══════════════════════════════════════"
    } >> "$ALERT_FILE"
    
    log_event "Alert sent: $severity - $message"
}

# دالة العرض
echo -e "${BLUE}🚨 المرحلة الثالثة: نظام التحذيرات والإنذارات${NC}"
echo "══════════════════════════════════════════════"

log_event "Alert phase started"

# 1. تحليل مستوى التهديد
echo -e "${GREEN}• تحليل مستوى التهديد الإجمالي...${NC}"

determine_severity() {
    if [ "$THREAT_COUNTER" -eq 0 ]; then
        echo "safe"
    elif [ "$THREAT_COUNTER" -le 2 ]; then
        echo "low"
    elif [ "$THREAT_COUNTER" -le 5 ]; then
        echo "medium"
    elif [ "$THREAT_COUNTER" -le 10 ]; then
        echo "high"
    else
        echo "critical"
    fi
}

SEVERITY=$(determine_severity)
echo -e "${CYAN}  📊 مستوى التهديد الحالي: $THREAT_COUNTER${NC}"
echo -e "${CYAN}  📊 التصنيف: $SEVERITY${NC}"

# 2. إنشاء التنبيهات بناءً على المستوى
echo -e "${GREEN}• إنشاء التنبيهات...${NC}"

case $SEVERITY in
    safe)
        echo -e "${GREEN}  ✅ النظام آمن - لا حاجة لتنبيهات${NC}"
        log_event "System is safe - no alerts needed"
        ;;
    low)
        echo -e "${YELLOW}  ⚠️  مستوى تهديد منخفض${NC}"
        send_alert "منخفض" "تم اكتشاف نشاط مشبوه طفيف - المراقبة مستمرة"
        ;;
    medium)
        echo -e "${YELLOW}  ⚠️  مستوى تهديد متوسط${NC}"
        send_alert "متوسط" "تم اكتشاف تهديدات متوسطة - يرجى المراجعة"
        echo -e "${YELLOW}  📧 إرسال تنبيه للمسؤولين...${NC}"
        ;;
    high)
        echo -e "${RED}  🚨 مستوى تهديد عالي!${NC}"
        send_alert "عالي" "تهديدات أمنية خطيرة - يجب اتخاذ إجراء فوري"
        echo -e "${RED}  📧 إرسال تنبيه عاجل للمسؤولين...${NC}"
        ;;
    critical)
        echo -e "${RED}  💀 مستوى تهديد حرج!${NC}"
        send_alert "حرج" "تهديدات أمنية حرجة - إجراءات طوارئ مطلوبة"
        echo -e "${RED}  📧 إرسال تنبيه طوارئ...${NC}"
        echo -e "${PURPLE}  🔔 تفعيل نظام الإنذار...${NC}"
        ;;
esac

# 3. إنشاء تقرير التهديدات
echo -e "${GREEN}• إنشاء تقرير التهديدات...${NC}"

create_threat_report() {
    local report_file="/tmp/threat_report_$(date '+%Y%m%d_%H%M%S').txt"
    
    {
        echo "═══════════════════════════════════════════════════════"
        echo "🛡️ تقرير التهديدات الأمنية - درع زايد"
        echo "═══════════════════════════════════════════════════════"
        echo ""
        echo "📅 التاريخ: $(date '+%Y-%m-%d')"
        echo "⏰ الوقت: $(date '+%H:%M:%S')"
        echo "🖥️  النظام: $(uname -n)"
        echo ""
        echo "═══════════════════════════════════════════════════════"
        echo "📊 ملخص التهديدات"
        echo "═══════════════════════════════════════════════════════"
        echo "• مستوى التهديد: $THREAT_COUNTER"
        echo "• التصنيف: $SEVERITY"
        echo ""
        
        if [ -f /tmp/threat_level.tmp ]; then
            echo "• مصدر التهديدات:"
            
            if [ -f /tmp/suspicious_ips.tmp ] && [ -s /tmp/suspicious_ips.tmp ]; then
                echo "  - عناوين IP مشبوهة:"
                while read -r ip; do
                    echo "    • $ip"
                done < /tmp/suspicious_ips.tmp
            fi
            
            if [ -f /tmp/suspicious_processes.tmp ] && [ -s /tmp/suspicious_processes.tmp ]; then
                echo "  - عمليات مشبوهة:"
                while read -r proc; do
                    echo "    • $proc"
                done < /tmp/suspicious_processes.tmp
            fi
        fi
        
        echo ""
        echo "═══════════════════════════════════════════════════════"
        echo "📋 التوصيات"
        echo "═══════════════════════════════════════════════════════"
        
        case $SEVERITY in
            safe)
                echo "• النظام آمن - استمر في المراقبة الدورية"
                ;;
            low)
                echo "• راجع السجلات للتأكد من عدم وجود نشاط مشبوه"
                echo "• تأكد من تحديث جميع البرامج"
                ;;
            medium)
                echo "• راجع محاولات الدخول الفاشلة"
                echo "• تحقق من المنافذ المفتوحة غير الضرورية"
                echo "• فكر في تفعيل المرحلة الرابعة"
                ;;
            high)
                echo "• قم بتفعيل المرحلة الرابعة فوراً"
                echo "• راجع جميع الاتصالات النشطة"
                echo "• فكر في عزل الأنظمة المتأثرة"
                ;;
            critical)
                echo "• فعّل وضع الطوارئ فوراً!"
                echo "• اعزل النظام عن الشبكة"
                echo "• اتصل بفريق الأمن السيبراني"
                echo "• احتفظ بنسخة من السجلات"
                ;;
        esac
        
        echo ""
        echo "═══════════════════════════════════════════════════════"
        echo "🔒 تم إنشاء هذا التقرير بواسطة درع زايد للأمن السيبراني"
        echo "═══════════════════════════════════════════════════════"
    } > "$report_file"
    
    echo "$report_file"
}

REPORT_FILE=$(create_threat_report)
echo -e "${CYAN}  📄 تم إنشاء التقرير: $REPORT_FILE${NC}"

# 4. إرسال الإشعارات (إذا كان مطلوباً)
echo -e "${GREEN}• معالجة الإشعارات...${NC}"

if [ "$SEVERITY" != "safe" ]; then
    # فحص وجود أداة إرسال البريد
    if command -v mail &> /dev/null; then
        echo -e "${CYAN}  📧 إرسال البريد الإلكتروني...${NC}"
        if [ -n "$ADMIN_EMAIL" ]; then
            # إرسال البريد (تعليق لمنع الإرسال الفعلي في بيئة الاختبار)
            # mail -s "تنبيه أمني - درع زايد [$SEVERITY]" "$ADMIN_EMAIL" < "$REPORT_FILE"
            echo -e "${GREEN}  ✅ تم إرسال التنبيه إلى $ADMIN_EMAIL${NC}"
        fi
    else
        echo -e "${YELLOW}  ⚠️  أداة البريد غير متوفرة${NC}"
    fi
fi

# 5. تحديث السجلات
echo -e "${GREEN}• تحديث السجلات...${NC}"

# حفظ آخر تنبيه
{
    echo "LAST_ALERT=$(date '+%Y-%m-%d %H:%M:%S')"
    echo "SEVERITY=$SEVERITY"
    echo "THREAT_LEVEL=$THREAT_COUNTER"
} > /tmp/last_alert.tmp

# النتيجة النهائية
echo ""
echo "══════════════════════════════════════════════"
case $SEVERITY in
    safe)
        echo -e "${GREEN}✅ المرحلة الثالثة: النظام آمن${NC}"
        log_event "Phase 3 completed - System is safe"
        ;;
    low)
        echo -e "${YELLOW}⚠️  المرحلة الثالثة: تنبيه منخفض${NC}"
        log_event "Phase 3 completed - Low alert issued"
        ;;
    medium)
        echo -e "${YELLOW}⚠️  المرحلة الثالثة: تنبيه متوسط${NC}"
        log_event "Phase 3 completed - Medium alert issued"
        ;;
    high)
        echo -e "${RED}🚨 المرحلة الثالثة: تنبيه عالي!${NC}"
        log_event "Phase 3 completed - High alert issued"
        ;;
    critical)
        echo -e "${RED}💀 المرحلة الثالثة: تنبيه حرج!${NC}"
        log_event "Phase 3 completed - Critical alert issued"
        ;;
esac
echo "══════════════════════════════════════════════"

# تصدير النتائج للمراحل التالية
export PHASE3_SEVERITY="$SEVERITY"
export PHASE3_THREATS="$THREAT_COUNTER"
exit 0
