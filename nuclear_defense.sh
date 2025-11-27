#!/bin/bash

# ═══════════════════════════════════════════════════════════════
# 💀🔥 النظام الدفاعي النووي - NUCLEAR DEFENSE SYSTEM 🔥💀
# Extreme Network Protection with Nuclear Response
# ═══════════════════════════════════════════════════════════════

# الألوان المتقدمة
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
BLINK='\033[5m'
NC='\033[0m'

# ملفات النظام المدمر
THREAT_LOG="/tmp/nuclear_threats.log"
STRIKE_LOG="/tmp/nuclear_strikes.log"
PRISON_LIST="/tmp/digital_prison.txt"
DESTRUCTION_LOG="/var/log/nuclear_defense.log"
BLACKHOLE_LIST="/tmp/blackhole_targets.txt"

# متغيرات التدمير
NUCLEAR_LEVEL=0
STRIKE_COUNT=0
PRISON_COUNT=0
AUTO_SCAN_INTERVAL=300  # 5 دقائق
THREAT_TOLERANCE=0      # صفر تساهل!

# دالة العرض المدمر
show_nuclear_header() {
    clear
    echo -e "${RED}${BOLD}████████████████████████████████████████████████████████████████${NC}"
    echo -e "${RED}${BOLD}██                                                            ██${NC}"
    echo -e "${RED}${BOLD}██  ${YELLOW}💀☢️🔥 NUCLEAR DEFENSE SYSTEM 🔥☢️💀${NC}  ${RED}${BOLD}██${NC}"
    echo -e "${RED}${BOLD}██                                                            ██${NC}"
    echo -e "${RED}${BOLD}██     ${BLINK}⚠️  EXTREME THREAT ELIMINATION MODE  ⚠️${NC}     ${RED}${BOLD}██${NC}"
    echo -e "${RED}${BOLD}██                                                            ██${NC}"
    echo -e "${RED}${BOLD}████████████████████████████████████████████████████████████████${NC}"
    echo -e "${YELLOW}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║  ${RED}${BLINK}💀 تحذير قاتل: نظام دفاعي بلا رحمة 💀${NC}  ${YELLOW}║${NC}"
    echo -e "${YELLOW}║  ${RED}🔥 أي تهديد = ضربة نووية فورية! 🔥${NC}          ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# دالة التسجيل المدمر
nuclear_log() {
    local level="$1"
    local message="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [☢️ $level] $message" | tee -a "$DESTRUCTION_LOG"
    
    # صوت إنذار نصي
    if [ "$level" == "NUCLEAR_STRIKE" ]; then
        echo -e "${RED}${BLINK}🚨🚨🚨 NUCLEAR STRIKE EXECUTED 🚨🚨🚨${NC}"
    fi
}

# دالة اكتشاف التهديدات المتوحشة
detect_threats() {
    echo -e "${RED}${BOLD}🔍 مسح التهديدات المدمر جاري...${NC}"
    echo -e "${YELLOW}⚡ البحث عن الأعداء في كل مكان...${NC}"
    
    NUCLEAR_LEVEL=0
    > "$THREAT_LOG"
    
    # الحصول على نطاق الشبكة
    NETWORK_RANGE=$(ip route | grep -E "192\.168\.|10\.0\.|172\." | head -1 | awk '{print $1}' | head -1)
    if [ -z "$NETWORK_RANGE" ]; then
        NETWORK_RANGE="192.168.1.0/24"
    fi
    
    echo -e "${CYAN}🌐 نطاق الصيد: $NETWORK_RANGE${NC}"
    nuclear_log "SCAN" "Threat detection started on $NETWORK_RANGE"
    
    # فحص الأجهزة المتصلة
    if command -v nmap >/dev/null 2>&1; then
        echo -e "${GREEN}💀 استخدام nmap للصيد المتقدم...${NC}"
        nmap -sS -O -sV --script vuln "$NETWORK_RANGE" 2>/dev/null | while IFS= read -r line; do
            if [[ $line == *"Nmap scan report"* ]]; then
                TARGET_IP=$(echo "$line" | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b')
                echo "TARGET: $TARGET_IP" >> "$THREAT_LOG"
            elif [[ $line == *"open"* ]]; then
                echo "OPEN_PORT: $line" >> "$THREAT_LOG"
                NUCLEAR_LEVEL=$((NUCLEAR_LEVEL + 1))
            elif [[ $line == *"vulnerable"* ]]; then
                echo "VULNERABILITY: $line" >> "$THREAT_LOG"
                NUCLEAR_LEVEL=$((NUCLEAR_LEVEL + 3))
            fi
        done
    else
        echo -e "${YELLOW}⚡ فحص أساسي بدون nmap...${NC}"
        BASE_IP=$(echo "$NETWORK_RANGE" | cut -d'/' -f1 | cut -d'.' -f1-3)
        for i in {1..254}; do
            TARGET_IP="$BASE_IP.$i"
            if timeout 1 ping -c1 "$TARGET_IP" >/dev/null 2>&1; then
                echo "TARGET: $TARGET_IP" >> "$THREAT_LOG"
                NUCLEAR_LEVEL=$((NUCLEAR_LEVEL + 1))
                
                # فحص منافذ خطيرة
                for port in 21 22 23 25 53 80 135 139 443 445 993 995 1433 3306 3389 5432; do
                    if timeout 1 bash -c "echo >/dev/tcp/$TARGET_IP/$port" 2>/dev/null; then
                        echo "DANGER_PORT: $TARGET_IP:$port" >> "$THREAT_LOG"
                        NUCLEAR_LEVEL=$((NUCLEAR_LEVEL + 2))
                    fi
                done
            fi
        done
    fi
    
    # فحص العمليات المشبوهة على الجهاز المحلي
    echo -e "${RED}🔍 فحص العمليات المحلية المشبوهة...${NC}"
    SUSPICIOUS_PROCESSES=$(ps aux | grep -E "(nc|netcat|nmap|hydra|metasploit|wireshark|tcpdump|aircrack|hashcat|john|sqlmap)" | grep -v grep | wc -l)
    
    if [ "$SUSPICIOUS_PROCESSES" -gt 0 ]; then
        echo "LOCAL_THREATS: $SUSPICIOUS_PROCESSES suspicious processes" >> "$THREAT_LOG"
        NUCLEAR_LEVEL=$((NUCLEAR_LEVEL + 5))
        echo -e "${RED}💀 عمليات خبيثة محلية: $SUSPICIOUS_PROCESSES${NC}"
    fi
    
    # فحص محاولات الدخول
    FAILED_LOGINS=0
    if [ -f /var/log/auth.log ]; then
        FAILED_LOGINS=$(tail -n 200 /var/log/auth.log | grep -c "Failed password")
    elif [ -f /var/log/secure ]; then
        FAILED_LOGINS=$(tail -n 200 /var/log/secure | grep -c "Failed password")
    fi
    
    if [ "$FAILED_LOGINS" -gt 3 ]; then
        echo "BRUTE_FORCE: $FAILED_LOGINS failed attempts" >> "$THREAT_LOG"
        NUCLEAR_LEVEL=$((NUCLEAR_LEVEL + 10))
        echo -e "${RED}💀 هجوم قاموس: $FAILED_LOGINS محاولة${NC}"
    fi
    
    # فحص الاتصالات المشبوهة
    SUSPICIOUS_CONNECTIONS=$(netstat -tuln 2>/dev/null | grep -E ":(1337|31337|4444|5555|6666|7777|8888|9999|12345)" | wc -l)
    if [ "$SUSPICIOUS_CONNECTIONS" -gt 0 ]; then
        echo "BACKDOOR_PORTS: $SUSPICIOUS_CONNECTIONS" >> "$THREAT_LOG"
        NUCLEAR_LEVEL=$((NUCLEAR_LEVEL + 15))
        echo -e "${RED}💀 منافذ خلفية مشبوهة: $SUSPICIOUS_CONNECTIONS${NC}"
    fi
    
    TARGET_COUNT=$(grep -c "TARGET:" "$THREAT_LOG" 2>/dev/null || echo "0")
    echo -e "${BLUE}📊 أهداف مكتشفة: $TARGET_COUNT${NC}"
    echo -e "${YELLOW}⚡ مستوى التهديد النووي: $NUCLEAR_LEVEL${NC}"
}

# دالة الضربة النووية
nuclear_strike() {
    local target="$1"
    local reason="$2"
    
    echo -e "\n${RED}${BOLD}💀☢️🔥 بدء الضربة النووية على $target 🔥☢️💀${NC}"
    echo -e "${YELLOW}السبب: $reason${NC}"
    
    # العد التنازلي المدمر
    for i in {3..1}; do
        echo -e "${RED}${BLINK}💥 $i 💥${NC}"
        sleep 1
    done
    
    echo -e "${RED}${BOLD}${BLINK}🚀 NUCLEAR LAUNCH! 🚀${NC}"
    
    # الضربة الفعلية - حظر متعدد المستويات
    {
        # حظر IP على مستوى النظام
        iptables -A INPUT -s "$target" -j DROP 2>/dev/null
        iptables -A OUTPUT -d "$target" -j DROP 2>/dev/null
        iptables -A FORWARD -s "$target" -j DROP 2>/dev/null
        iptables -A FORWARD -d "$target" -j DROP 2>/dev/null
        
        # إضافة لقائمة الثقب الأسود
        echo "$target" >> "$BLACKHOLE_LIST"
        
        # حظر على مستوى الـ route
        ip route add blackhole "$target" 2>/dev/null
        
        # سجن رقمي - معلومات كاملة
        {
            echo "═══════════════════════════════════════"
            echo "💀 NUCLEAR STRIKE EXECUTED 💀"
            echo "Target: $target"
            echo "Reason: $reason"
            echo "Time: $(date)"
            echo "Strike #: $((++STRIKE_COUNT))"
            echo "Status: DIGITALLY IMPRISONED"
            echo "═══════════════════════════════════════"
        } >> "$PRISON_LIST"
        
    } 2>/dev/null
    
    # تسجيل الضربة
    nuclear_log "NUCLEAR_STRIKE" "Target $target eliminated - Reason: $reason"
    
    echo -e "${GREEN}💀 تم تدمير الهدف $target بنجاح!${NC}"
    echo -e "${RED}🔒 الهدف محبوس في السجن الرقمي إلى الأبد!${NC}"
    
    PRISON_COUNT=$((PRISON_COUNT + 1))
}

# دالة التدمير الجماعي
mass_destruction() {
    echo -e "\n${RED}${BOLD}💀☢️ بدء التدمير الجماعي ☢️💀${NC}"
    echo -e "${YELLOW}🔥 لا رحمة... لا تساهل... تدمير شامل! 🔥${NC}"
    
    if [ ! -f "$THREAT_LOG" ] || [ ! -s "$THREAT_LOG" ]; then
        echo -e "${YELLOW}⚠️ لا توجد أهداف للتدمير${NC}"
        return
    fi
    
    # تدمير كل هدف مكتشف
    grep "TARGET:" "$THREAT_LOG" | while read -r line; do
        target_ip=$(echo "$line" | cut -d' ' -f2)
        
        # تحديد سبب التدمير
        reason="Unknown threat"
        if grep -q "VULNERABILITY.*$target_ip" "$THREAT_LOG"; then
            reason="Vulnerability detected"
        elif grep -q "DANGER_PORT.*$target_ip" "$THREAT_LOG"; then
            reason="Dangerous ports open"
        elif grep -q "BRUTE_FORCE" "$THREAT_LOG"; then
            reason="Brute force attack"
        fi
        
        nuclear_strike "$target_ip" "$reason"
        sleep 1
    done
    
    # تدمير العمليات المشبوهة محلياً
    ps aux | grep -E "(nc|netcat|nmap|hydra|metasploit)" | grep -v grep | while read -r process; do
        PID=$(echo "$process" | awk '{print $2}')
        COMMAND=$(echo "$process" | awk '{print $11}')
        
        echo -e "${RED}💀 تدمير العملية المشبوهة: $COMMAND (PID: $PID)${NC}"
        kill -9 "$PID" 2>/dev/null
        nuclear_log "PROCESS_KILL" "Suspicious process eliminated: $COMMAND"
    done
    
    echo -e "\n${GREEN}${BOLD}✅ التدمير الجماعي مكتمل!${NC}"
    echo -e "${RED}💀 تم سجن $PRISON_COUNT هدف في السجن الرقمي${NC}"
}

# دالة عرض السجن الرقمي
show_digital_prison() {
    show_nuclear_header
    echo -e "${RED}${BOLD}🔒💀 السجن الرقمي 💀🔒${NC}"
    echo "════════════════════════════════════════════════════════"
    
    if [ -f "$PRISON_LIST" ] && [ -s "$PRISON_LIST" ]; then
        echo -e "${YELLOW}👹 المساجين الرقميين:${NC}"
        cat "$PRISON_LIST"
        
        PRISONER_COUNT=$(grep -c "Target:" "$PRISON_LIST" 2>/dev/null || echo "0")
        echo -e "\n${RED}💀 إجمالي المساجين: $PRISONER_COUNT${NC}"
        echo -e "${GREEN}🔒 جميعهم محبوسين إلى الأبد!${NC}"
    else
        echo -e "${GREEN}✅ السجن فارغ حالياً${NC}"
        echo -e "${YELLOW}⚡ في انتظار أهداف جديدة للتدمير...${NC}"
    fi
    
    echo ""
    read -p "اضغط Enter للعودة..."
}

# دالة إطلاق سراح (للطوارئ فقط!)
emergency_release() {
    echo -e "${YELLOW}⚠️ إطلاق سراح طارئ - هل أنت متأكد؟${NC}"
    echo -e "${RED}💀 هذا سيحرر جميع المساجين الرقميين!${NC}"
    echo ""
    read -p "اكتب 'NUCLEAR_RELEASE' لتأكيد الإطلاق: " confirm
    
    if [ "$confirm" = "NUCLEAR_RELEASE" ]; then
        echo -e "${GREEN}🔓 جاري إطلاق سراح جميع المساجين...${NC}"
        
        # إزالة قواعد iptables
        if [ -f "$BLACKHOLE_LIST" ]; then
            while read -r target; do
                iptables -D INPUT -s "$target" -j DROP 2>/dev/null
                iptables -D OUTPUT -d "$target" -j DROP 2>/dev/null
                iptables -D FORWARD -s "$target" -j DROP 2>/dev/null
                ip route del blackhole "$target" 2>/dev/null
                echo -e "${YELLOW}🔓 تم تحرير: $target${NC}"
            done < "$BLACKHOLE_LIST"
        fi
        
        # مسح السجلات
        > "$PRISON_LIST"
        > "$BLACKHOLE_LIST"
        > "$THREAT_LOG"
        
        nuclear_log "EMERGENCY_RELEASE" "All digital prisoners released"
        echo -e "${GREEN}✅ تم إطلاق سراح جميع المساجين${NC}"
        PRISON_COUNT=0
    else
        echo -e "${RED}❌ إطلاق السراح ملغي${NC}"
    fi
    
    echo ""
    read -p "اضغط Enter للمتابعة..."
}

# دالة المراقبة التلقائية المدمرة
auto_nuclear_patrol() {
    show_nuclear_header
    echo -e "${RED}${BOLD}♾️ بدء الدورية النووية التلقائية ♾️${NC}"
    echo -e "${YELLOW}⚡ مسح كل $AUTO_SCAN_INTERVAL ثانية (5 دقائق)${NC}"
    echo -e "${RED}💀 تدمير فوري لأي تهديد!${NC}"
    echo -e "${BLINK}🚨 اضغط Ctrl+C للإيقاف 🚨${NC}"
    echo ""
    
    local patrol_count=0
    
    while true; do
        patrol_count=$((patrol_count + 1))
        
        echo -e "\n${CYAN}${BOLD}════════ الدورية النووية #$patrol_count ════════${NC}"
        echo -e "${BLUE}🕐 الوقت: $(date '+%H:%M:%S')${NC}"
        echo -e "${PURPLE}💀 البحث عن أهداف للتدمير...${NC}"
        
        # مسح التهديدات
        detect_threats
        
        # تقرير سريع
        echo -e "\n${YELLOW}📊 تقرير الدورية:${NC}"
        echo -e "${CYAN}  🎯 مستوى التهديد: $NUCLEAR_LEVEL${NC}"
        echo -e "${RED}  💀 مساجين رقميين: $PRISON_COUNT${NC}"
        
        # إذا كان هناك تهديدات - تدمير فوري
        if [ "$NUCLEAR_LEVEL" -gt "$THREAT_TOLERANCE" ]; then
            echo -e "\n${RED}${BOLD}${BLINK}🚨 تهديدات مكتشفة! بدء التدمير الفوري! 🚨${NC}"
            mass_destruction
        else
            echo -e "\n${GREEN}✅ الوضع آمن - لا توجد تهديدات${NC}"
        fi
        
        echo -e "\n${YELLOW}😴 نوم عميق لـ $AUTO_SCAN_INTERVAL ثانية...${NC}"
        echo -e "${BLUE}💤 الدورية التالية في: $(date -d "+$AUTO_SCAN_INTERVAL seconds" '+%H:%M:%S')${NC}"
        
        # العد التنازلي البصري
        for ((i=AUTO_SCAN_INTERVAL; i>0; i-=10)); do
            echo -e "${PURPLE}⏰ متبقي: $i ثانية${NC}"
            sleep 10
        done
    done
}

# دالة الإحصائيات المدمرة
show_destruction_stats() {
    show_nuclear_header
    echo -e "${RED}${BOLD}📊💀 إحصائيات التدمير 💀📊${NC}"
    echo "════════════════════════════════════════════════════════"
    
    # حساب الإحصائيات
    TOTAL_STRIKES=$(grep -c "NUCLEAR_STRIKE" "$DESTRUCTION_LOG" 2>/dev/null || echo "0")
    CURRENT_PRISONERS=$(grep -c "Target:" "$PRISON_LIST" 2>/dev/null || echo "0")
    PROCESS_KILLS=$(grep -c "PROCESS_KILL" "$DESTRUCTION_LOG" 2>/dev/null || echo "0")
    
    echo -e "${RED}💀 إجمالي الضربات النووية: $TOTAL_STRIKES${NC}"
    echo -e "${YELLOW}🔒 المساجين الحاليين: $CURRENT_PRISONERS${NC}"
    echo -e "${PURPLE}⚔️  العمليات المدمرة: $PROCESS_KILLS${NC}"
    echo -e "${CYAN}📅 تاريخ آخر ضربة: $(tail -1 "$DESTRUCTION_LOG" 2>/dev/null | cut -d']' -f1 | tr -d '[' || echo "لا توجد")${NC}"
    
    echo ""
    echo -e "${GREEN}${BOLD}🏆 معدل النجاح: 100%${NC}"
    echo -e "${RED}${BOLD}💀 معدل البقاء للأعداء: 0%${NC}"
    
    if [ -f "$DESTRUCTION_LOG" ]; then
        echo -e "\n${BLUE}📋 آخر 5 ضربات نووية:${NC}"
        echo "────────────────────────────────────"
        grep "NUCLEAR_STRIKE" "$DESTRUCTION_LOG" | tail -5
    fi
    
    echo ""
    read -p "اضغط Enter للعودة..."
}

# القائمة الرئيسية المدمرة
show_main_menu() {
    show_nuclear_header
    echo "اختر نمط التدمير:"
    echo ""
    echo -e "1. ${RED}🔍 مسح وتحديد الأهداف${NC}"
    echo -e "2. ${RED}💀 ضربة نووية واحدة${NC}"
    echo -e "3. ${RED}☢️  تدمير جماعي شامل${NC}"
    echo -e "4. ${PURPLE}♾️  الدورية النووية التلقائية${NC}"
    echo -e "5. ${BLUE}🔒 عرض السجن الرقمي${NC}"
    echo -e "6. ${GREEN}📊 إحصائيات التدمير${NC}"
    echo -e "7. ${YELLOW}🔓 إطلاق سراح طارئ${NC}"
    echo -e "8. ${CYAN}📝 عرض سجلات التدمير${NC}"
    echo -e "9. ${WHITE}🚪 خروج${NC}"
    echo ""
    read -p "اختيارك (1-9): " choice
}

# دالة عرض السجلات
show_destruction_logs() {
    show_nuclear_header
    echo -e "${BLUE}${BOLD}📝 سجلات التدمير النووي${NC}"
    echo "════════════════════════════════════════════════════════"
    
    if [ -f "$DESTRUCTION_LOG" ] && [ -s "$DESTRUCTION_LOG" ]; then
        echo -e "${GREEN}📋 آخر 25 حدث مدمر:${NC}"
        echo "────────────────────────────────────"
        tail -25 "$DESTRUCTION_LOG"
    else
        echo -e "${YELLOW}📋 لا توجد سجلات تدمير بعد${NC}"
        echo -e "${RED}💀 ابدأ بتدمير بعض الأهداف!${NC}"
    fi
    
    echo ""
    read -p "اضغط Enter للعودة..."
}

# دالة التهيئة النووية
nuclear_initialization() {
    # إنشاء الملفات
    touch "$THREAT_LOG" "$STRIKE_LOG" "$PRISON_LIST" "$DESTRUCTION_LOG" "$BLACKHOLE_LIST"
    
    # تسجيل بداية النظام
    nuclear_log "SYSTEM" "Nuclear Defense System activated - Maximum threat level"
    
    # فحص الصلاحيات
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}⚠️ تحذير: تحتاج صلاحيات root للتدمير الكامل!${NC}"
        echo -e "${YELLOW}💡 شغل النظام بـ sudo للقوة القاتلة الكاملة${NC}"
        sleep 3
    fi
    
    echo -e "${GREEN}✅ النظام النووي جاهز للتدمير!${NC}"
    sleep 1
}

# البرنامج الرئيسي المدمر
main() {
    nuclear_initialization
    
    while true; do
        show_main_menu
        
        case $choice in
            1)
                show_nuclear_header
                echo -e "${GREEN}🔍 بدء مسح الأهداف...${NC}"
                detect_threats
                echo -e "\n${BLUE}✅ المسح مكتمل - مستوى التهديد: $NUCLEAR_LEVEL${NC}"
                read -p "اضغط Enter للعودة..."
                ;;
            2)
                echo ""
                read -p "أدخل IP الهدف للتدمير: " target_ip
                if [[ $target_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                    nuclear_strike "$target_ip" "Manual target elimination"
                else
                    echo -e "${RED}❌ عنوان IP غير صحيح${NC}"
                fi
                read -p "اضغط Enter للمتابعة..."
                ;;
            3)
                show_nuclear_header
                echo -e "${RED}☢️ بدء التدمير الجماعي...${NC}"
                detect_threats
                if [ "$NUCLEAR_LEVEL" -gt 0 ]; then
                    mass_destruction
                else
                    echo -e "${YELLOW}⚠️ لا توجد أهداف للتدمير${NC}"
                fi
                read -p "اضغط Enter للعودة..."
                ;;
            4)
                auto_nuclear_patrol
                ;;
            5)
                show_digital_prison
                ;;
            6)
                show_destruction_stats
                ;;
            7)
                emergency_release
                ;;
            8)
                show_destruction_logs
                ;;
            9)
                echo -e "${GREEN}👋 النظام النووي في وضع السكون...${NC}"
                nuclear_log "SYSTEM" "Nuclear Defense System deactivated"
                echo -e "${RED}💀 جاهز للعودة في أي وقت للتدمير!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ اختيار خاطئ - سيتم تدميرك! (مزحة 😈)${NC}"
                sleep 1
                ;;
        esac
    done
}

# معالج الإيقاف المدمر
trap 'echo -e "\n${RED}🛑 النظام النووي في وضع السكون${NC}"; nuclear_log "SYSTEM" "Nuclear system interrupted"; exit 0' INT

# بداية التدمير!
echo -e "${RED}${BOLD}${BLINK}💀☢️🔥 النظام النووي يستيقظ... 🔥☢️💀${NC}"
sleep 2
main
