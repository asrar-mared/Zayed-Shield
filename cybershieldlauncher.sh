#!/bin/bash

# ===========================================
# درع زايد - نظام الحماية السيبرانية المرحلي
# UAE Cyber Shield - Staged Defense System
# ===========================================

# متغيرات النظام
LOG_FILE="/var/log/cyber_shield.log"
ALERT_FILE="/tmp/security_alerts.txt"
THREAT_COUNTER=0
BLOCK_LIST="/tmp/blocked_ips.txt"

# الألوان
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# دالة التسجيل
log_event() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# دالة العرض المنظم
show_header() {
    clear
    echo -e "${BLUE}══════════════════════════════════════════${NC}"
    echo -e "${BLUE}🛡️  درع زايد - نظام الحماية السيبرانية  🛡️${NC}"
    echo -e "${BLUE}══════════════════════════════════════════${NC}"
    echo ""
}

# المرحلة 1: التصدي والكشف
phase1_detection() {
    echo -e "${GREEN}🔍 المرحلة 1: بدء عملية التصدي والكشف...${NC}"
    log_event "Phase 1: Detection started"
    
    # مراقبة الاتصالات المشبوهة
    echo "• فحص الاتصالات الواردة..."
    netstat -tuln | grep ESTABLISHED > /tmp/connections.tmp
    
    # تحليل اللوغات
    echo "• تحليل ملفات السجل..."
    tail -n 100 /var/log/auth.log | grep "Failed password" | wc -l > /tmp/failed_logins.count
    
    # فحص العمليات المشبوهة
    echo "• مراقبة العمليات..."
    ps aux | grep -E "(nc|nmap|hydra|metasploit)" | grep -v grep > /tmp/suspicious_processes.tmp
    
    FAILED_LOGINS=$(cat /tmp/failed_logins.count)
    if [ "$FAILED_LOGINS" -gt 5 ]; then
        THREAT_COUNTER=$((THREAT_COUNTER + 1))
        echo -e "${YELLOW}⚠️  تم اكتشاف محاولات دخول مشبوهة: $FAILED_LOGINS${NC}"
    fi
    
    echo -e "${GREEN}✅ المرحلة 1 مكتملة${NC}"
    sleep 2
}

# المرحلة 2: المراقبة المتقدمة
phase2_monitoring() {
    echo -e "${GREEN}📊 المرحلة 2: بدء المراقبة المتقدمة...${NC}"
    log_event "Phase 2: Advanced monitoring started"
    
    # مراقبة استخدام الموارد
    echo "• مراقبة استخدام CPU والذاكرة..."
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    
    if (( $(echo "$CPU_USAGE > 80" | bc -l) )); then
        THREAT_COUNTER=$((THREAT_COUNTER + 1))
        echo -e "${YELLOW}⚠️  استخدام CPU مرتفع: ${CPU_USAGE}%${NC}"
    fi
    
    # مراقبة الشبكة
    echo "• فحص حركة الشبكة..."
    ss -tuln | grep :22 > /tmp/ssh_connections.tmp
    
    # تحليل DNS
    echo "• تحليل طلبات DNS المشبوهة..."
    tail -n 50 /var/log/syslog | grep "DNS" | grep -E "(malware|phishing|botnet)" > /tmp/dns_threats.tmp
    
    if [ -s /tmp/dns_threats.tmp ]; then
        THREAT_COUNTER=$((THREAT_COUNTER + 2))
        echo -e "${YELLOW}⚠️  تم اكتشاف طلبات DNS مشبوهة${NC}"
    fi
    
    echo -e "${GREEN}✅ المرحلة 2 مكتملة${NC}"
    sleep 2
}

# المرحلة 3: التحذيرات والإنذارات
phase3_alerts() {
    echo -e "${GREEN}🚨 المرحلة 3: نظام التحذيرات...${NC}"
    log_event "Phase 3: Alert system activated"
    
    if [ $THREAT_COUNTER -gt 0 ]; then
        echo -e "${RED}🚨 تحذير أمني: تم اكتشاف $THREAT_COUNTER تهديد${NC}"
        
        # إنشاء تقرير التهديدات
        {
            echo "=== تقرير التهديدات الأمنية ==="
            echo "التوقيت: $(date)"
            echo "مستوى التهديد: $THREAT_COUNTER"
            echo "================================="
        } > "$ALERT_FILE"
        
        # إرسال تنبيه للمسؤول
        if command -v mail &> /dev/null; then
            echo "تحذير أمني من درع زايد - تم اكتشاف تهديدات" | mail -s "Security Alert" admin@company.ae
        fi
        
        echo -e "${YELLOW}📧 تم إرسال تحذير للمسؤولين${NC}"
    else
        echo -e "${GREEN}✅ لا توجد تهديدات مكتشفة${NC}"
    fi
    
    echo -e "${GREEN}✅ المرحلة 3 مكتملة${NC}"
    sleep 2
}

# المرحلة 4: الهجوم المرحلي (الدفاع الفعال)
phase4_active_defense() {
    echo -e "${GREEN}⚔️  المرحلة 4: الدفاع الفعال...${NC}"
    log_event "Phase 4: Active defense initiated"
    
    if [ $THREAT_COUNTER -gt 2 ]; then
        echo -e "${RED}🛡️  بدء إجراءات الدفاع الفعال...${NC}"
        
        # حظر IPs المشبوهة
        echo "• حظر العناوين المشبوهة..."
        if [ -f /tmp/suspicious_ips.tmp ]; then
            while read -r ip; do
                if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                    echo "$ip" >> "$BLOCK_LIST"
                    iptables -A INPUT -s "$ip" -j DROP 2>/dev/null
                    echo -e "${RED}🚫 تم حظر IP: $ip${NC}"
                fi
            done < /tmp/suspicious_ips.tmp
        fi
        
        # تقييد الخدمات
        echo "• تقييد الخدمات الحساسة..."
        
        # إيقاف الخدمات غير الضرورية
        services=("telnet" "rsh" "ftp")
        for service in "${services[@]}"; do
            if systemctl is-active --quiet "$service"; then
                systemctl stop "$service" 2>/dev/null
                echo -e "${YELLOW}⏹️  تم إيقاف خدمة: $service${NC}"
            fi
        done
        
        # تحديث قواعد الجدار الناري
        echo "• تحديث جدار الحماية..."
        iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
        iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
        
        echo -e "${RED}🛡️  تم تفعيل الحماية المشددة${NC}"
    fi
    
    echo -e "${GREEN}✅ المرحلة 4 مكتملة${NC}"
    sleep 2
}

# دالة المراقبة المستمرة
continuous_monitoring() {
    echo -e "${BLUE}♾️  بدء المراقبة المستمرة...${NC}"
    
    while true; do
        echo -e "\n${BLUE}─────────────────────────────────${NC}"
        echo -e "${BLUE}🔄 دورة مراقبة جديدة - $(date '+%H:%M:%S')${NC}"
        echo -e "${BLUE}─────────────────────────────────${NC}"
        
        THREAT_COUNTER=0
        
        phase1_detection
        phase2_monitoring
        phase3_alerts
        
        if [ $THREAT_COUNTER -gt 2 ]; then
            phase4_active_defense
        fi
        
        echo -e "\n${GREEN}💤 انتظار 30 ثانية قبل الدورة التالية...${NC}"
        sleep 30
        
        # إمكانية الإيقاف بـ Ctrl+C
        trap 'echo -e "\n${RED}🛑 تم إيقاف النظام بواسطة المستخدم${NC}"; exit 0' INT
    done
}

# دالة عرض القائمة الرئيسية
show_menu() {
    show_header
    echo "اختر نمط التشغيل:"
    echo "1. 🔍 المرحلة الأولى فقط (التصدي)"
    echo "2. 📊 المرحلة الثانية فقط (المراقبة)"
    echo "3. 🚨 المرحلة الثالثة فقط (التحذيرات)"
    echo "4. ⚔️  المرحلة الرابعة فقط (الدفاع الفعال)"
    echo "5. 🔄 تشغيل جميع المراحل مرة واحدة"
    echo "6. ♾️  المراقبة المستمرة"
    echo "7. 📊 عرض التقارير"
    echo "8. 🚪 خروج"
    echo ""
    read -p "اختيارك (1-8): " choice
}

# دالة عرض التقارير
show_reports() {
    show_header
    echo -e "${BLUE}📊 التقارير والإحصائيات${NC}"
    echo "────────────────────────"
    
    if [ -f "$LOG_FILE" ]; then
        echo "📁 آخر 10 أحداث:"
        tail -n 10 "$LOG_FILE"
    else
        echo "لا توجد سجلات متاحة"
    fi
    
    echo ""
    read -p "اضغط Enter للعودة..."
}

# البرنامج الرئيسي
main() {
    # إنشاء الملفات المطلوبة
    touch "$LOG_FILE" "$ALERT_FILE" "$BLOCK_LIST"
    
    log_event "Cyber Shield System Started"
    
    while true; do
        show_menu
        
        case $choice in
            1)
                show_header
                phase1_detection
                read -p "اضغط Enter للعودة..."
                ;;
            2)
                show_header
                phase2_monitoring
                read -p "اضغط Enter للعودة..."
                ;;
            3)
                show_header
                phase3_alerts
                read -p "اضغط Enter للعودة..."
                ;;
            4)
                show_header
                phase4_active_defense
                read -p "اضغط Enter للعودة..."
                ;;
            5)
                show_header
                phase1_detection
                phase2_monitoring
                phase3_alerts
                if [ $THREAT_COUNTER -gt 2 ]; then
                    phase4_active_defense
                fi
                read -p "اضغط Enter للعودة..."
                ;;
            6)
                show_header
                continuous_monitoring
                ;;
            7)
                show_reports
                ;;
            8)
                echo -e "${GREEN}👋 شكراً لاستخدام درع زايد${NC}"
                log_event "System shutdown by user"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ اختيار غير صحيح${NC}"
                sleep 1
                ;;
        esac
    done
}

# تشغيل البرنامج
main
