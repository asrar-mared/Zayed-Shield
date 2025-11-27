#!/bin/bash

# ===========================================
# درع زايد - المشغل الرئيسي
# UAE Cyber Shield - Main Launcher
# ===========================================

# الألوان
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# المتغيرات العامة
export LOG_FILE="/var/log/cyber_shield.log"
export ALERT_FILE="/tmp/security_alerts.txt"
export BLOCK_LIST="/tmp/blocked_ips.txt"

# دالة العرض المطورة
show_header() {
    clear
    echo -e "${RED}████████████████████████████████████████████████████${NC}"
    echo -e "${RED}██                                                ██${NC}"
    echo -e "${RED}██  ${YELLOW}💀 ⚔️  نظام درع زايد المتقدم  ⚔️  💀${NC}  ${RED}██${NC}"
    echo -e "${RED}██     ${BLUE}🔥 ADVANCED CYBER WARFARE SHIELD 🔥${NC}     ${RED}██${NC}"
    echo -e "${RED}██                                                ██${NC}"
    echo -e "${RED}██    ${YELLOW}⚡ مشغل الحرب الإلكترونية المتطور ⚡${NC}    ${RED}██${NC}"
    echo -e "${RED}██                                                ██${NC}"
    echo -e "${RED}████████████████████████████████████████████████████${NC}"
    echo -e "${YELLOW}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║  ${RED}🚨 تحذير: نظام حماية عالي المستوى 🚨${NC}  ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════════════════╝${NC}"
    echo ""
}

# دالة التحقق من الملفات
check_files() {
    files=("phase1_detection.sh" "phase2_monitoring.sh" "phase3_alerts.sh" "phase4_defense.sh")
    
    for file in "${files[@]}"; do
        if [ ! -f "$file" ]; then
            echo -e "${RED}❌ الملف مفقود: $file${NC}"
            exit 1
        fi
        chmod +x "$file"
    done
    
    # إنشاء ملفات النظام
    touch "$LOG_FILE" "$ALERT_FILE" "$BLOCK_LIST"
}

# دالة القائمة الرئيسية
show_menu() {
    show_header
    echo "اختر نمط التشغيل:"
    echo "1. 🔍 المرحلة الأولى - التصدي والكشف"
    echo "2. 📊 المرحلة الثانية - المراقبة المتقدمة"
    echo "3. 🚨 المرحلة الثالثة - التحذيرات والإنذارات"
    echo "4. ⚔️  المرحلة الرابعة - الدفاع الفعال"
    echo "5. 🔄 تشغيل جميع المراحل"
    echo "6. ♾️  المراقبة المستمرة"
    echo "7. 📊 عرض السجلات"
    echo "8. 🚪 خروج"
    echo ""
    read -p "اختيارك (1-8): " choice
}

# دالة المراقبة المستمرة
continuous_mode() {
    echo -e "${BLUE}♾️  بدء المراقبة المستمرة...${NC}"
    echo -e "${YELLOW}اضغط Ctrl+C للإيقاف${NC}"
    sleep 3
    
    while true; do
        echo -e "\n${BLUE}──────────────────────────────────────${NC}"
        echo -e "${BLUE}🔄 دورة جديدة - $(date '+%H:%M:%S')${NC}"
        echo -e "${BLUE}──────────────────────────────────────${NC}"
        
        ./phase1_detection.sh
        ./phase2_monitoring.sh
        ./phase3_alerts.sh
        
        # إذا كان هناك تهديدات، شغل المرحلة الرابعة
        if [ -f "/tmp/threat_level.tmp" ]; then
            THREATS=$(cat /tmp/threat_level.tmp)
            if [ "$THREATS" -gt 2 ]; then
                ./phase4_defense.sh
            fi
        fi
        
        echo -e "\n${GREEN}💤 انتظار 30 ثانية...${NC}"
        sleep 30
    done
}

# دالة عرض السجلات
show_logs() {
    show_header
    echo -e "${BLUE}📊 آخر الأحداث المسجلة${NC}"
    echo "────────────────────────────────────"
    
    if [ -f "$LOG_FILE" ]; then
        tail -n 15 "$LOG_FILE"
    else
        echo "لا توجد سجلات"
    fi
    
    echo ""
    read -p "اضغط Enter للعودة..."
}

# البرنامج الرئيسي
main() {
    # التحقق من الملفات
    check_files
    
    # تسجيل بداية التشغيل
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] System started" >> "$LOG_FILE"
    
    # حلقة القائمة الرئيسية
    while true; do
        show_menu
        
        case $choice in
            1)
                show_header
                echo -e "${GREEN}🔍 تشغيل المرحلة الأولى...${NC}"
                ./phase1_detection.sh
                read -p "اضغط Enter للعودة..."
                ;;
            2)
                show_header
                echo -e "${GREEN}📊 تشغيل المرحلة الثانية...${NC}"
                ./phase2_monitoring.sh
                read -p "اضغط Enter للعودة..."
                ;;
            3)
                show_header
                echo -e "${GREEN}🚨 تشغيل المرحلة الثالثة...${NC}"
                ./phase3_alerts.sh
                read -p "اضغط Enter للعودة..."
                ;;
            4)
                show_header
                echo -e "${GREEN}⚔️  تشغيل المرحلة الرابعة...${NC}"
                ./phase4_defense.sh
                read -p "اضغط Enter للعودة..."
                ;;
            5)
                show_header
                echo -e "${GREEN}🔄 تشغيل جميع المراحل...${NC}"
                ./phase1_detection.sh
                ./phase2_monitoring.sh
                ./phase3_alerts.sh
                
                if [ -f "/tmp/threat_level.tmp" ]; then
                    THREATS=$(cat /tmp/threat_level.tmp)
                    if [ "$THREATS" -gt 2 ]; then
                        ./phase4_defense.sh
                    fi
                fi
                
                read -p "اضغط Enter للعودة..."
                ;;
            6)
                continuous_mode
                ;;
            7)
                show_logs
                ;;
            8)
                echo -e "${GREEN}👋 شكراً لاستخدام درع زايد${NC}"
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] System shutdown" >> "$LOG_FILE"
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
trap 'echo -e "\n${RED}🛑 تم الإيقاف${NC}"; exit 0' INT
main
