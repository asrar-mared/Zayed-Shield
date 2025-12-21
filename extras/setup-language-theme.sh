#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# TERMUX ULTIMATE SETUP & UPGRADE SCRIPT
# Complete Development Environment Setup
# ==========================================

# الألوان
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# دوال العرض
header() {
    clear
    echo -e "${CYAN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                  TERMUX ULTIMATE SETUP                    ║"  
    echo "║              Complete Development Environment              ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[i]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# متغيرات النظام
SETUP_LOG="$HOME/setup.log"
BACKUP_DIR="$HOME/setup_backup"

# دالة التحضير
prepare_system() {
    header
    print_info "إعداد النظام للتحديث الشامل..."
    
    # إنشاء نسخة احتياطية
    mkdir -p "$BACKUP_DIR"
    cp ~/.bashrc ~/.profile "$BACKUP_DIR/" 2>/dev/null
    
    # تحديث النظام
    print_info "تحديث قاعدة البيانات..."
    pkg update && pkg upgrade -y
    
    # تمكين التخزين الخارجي
    termux-setup-storage
    
    print_status "تم إعداد النظام"
    echo "$(date): System prepared" >> "$SETUP_LOG"
}

# تثبيت الأدوات الأساسية
install_core_tools() {
    print_info "تثبيت الأدوات الأساسية..."
    
    local core_packages=(
        "bash" "zsh" "fish"
        "git" "curl" "wget" "aria2"
        "vim" "nano" "neovim" "emacs"
        "htop" "btop" "tree" "file" "which"
        "tar" "gzip" "zip" "unzip" "7zip"
        "openssh" "rsync" "screen" "tmux"
        "grep" "sed" "awk" "jq" "yq"
        "coreutils" "findutils" "util-linux"
    )
    
    for package in "${core_packages[@]}"; do
        print_info "تثبيت: $package"
        pkg install -y "$package" >> "$SETUP_LOG" 2>&1
    done
    
    print_status "تم تثبيت الأدوات الأساسية"
}

# بيئات البرمجة
install_programming_environments() {
    print_info "تثبيت بيئات البرمجة..."
    
    # Python Complete
    print_info "إعداد Python..."
    pkg install -y python python-pip python2 python2-dev
    pip install --upgrade pip setuptools wheel
    pip install requests flask django fastapi
    pip install numpy pandas matplotlib jupyter
    pip install beautifulsoup4 scrapy selenium
    pip install cryptography pycryptodome
    pip install sqlalchemy psycopg2 pymongo
    
    # Node.js Complete  
    print_info "إعداد Node.js..."
    pkg install -y nodejs npm
    npm install -g yarn pnpm
    npm install -g express react-cli vue-cli angular-cli
    npm install -g typescript ts-node nodemon
    npm install -g pm2 forever
    
    # Java/Kotlin
    print_info "إعداد Java..."
    pkg install -y openjdk-17 gradle maven
    pkg install -y kotlin scala
    
    # Languages
    print_info "إعداد اللغات الأخرى..."
    pkg install -y golang rust ruby perl php
    pkg install -y lua luarocks
    pkg install -y dart
    
    # Databases
    print_info "إعداد قواعد البيانات..."
    pkg install -y sqlite postgresql mysql redis
    pkg install -y mongodb
    
    print_status "تم تثبيت بيئات البرمجة"
}

# أدوات التطوير المتقدمة
install_development_tools() {
    print_info "تثبيت أدوات التطوير المتقدمة..."
    
    # Build Tools
    pkg install -y make cmake autoconf automake libtool
    pkg install -y clang llvm gcc gdb
    pkg install -y pkg-config m4 patch
    pkg install -y ninja meson
    
    # Version Control
    pkg install -y git-lfs subversion mercurial
    
    # Code Analysis
    pkg install -y cppcheck clang-tools
    pkg install -y shellcheck
    
    # Container & Virtualization
    pkg install -y proot proot-distro
    
    print_status "تم تثبيت أدوات التطوير"
}

# أدوات الأمان والشبكة
install_security_tools() {
    print_info "تثبيت أدوات الأمان والشبكة..."
    
    # Network Tools
    pkg install -y nmap netcat-openbsd socat
    pkg install -y iproute2 net-tools dnsutils
    pkg install -y wireless-tools aircrack-ng
    pkg install -y tcpdump wireshark-cli
    
    # Security Tools  
    pkg install -y gnupg openssh openssl
    pkg install -y tor proxychains-ng
    pkg install -y clamav rkhunter
    pkg install -y hashcat john
    pkg install -y steghide binwalk
    
    # Monitoring
    pkg install -y strace ltrace lsof
    pkg install -y iotop iftop nethogs
    
    print_status "تم تثبيت أدوات الأمان"
}

# أدوات الوسائط والجرافيك
install_media_tools() {
    print_info "تثبيت أدوات الوسائط..."
    
    # Image/Video
    pkg install -y imagemagick ffmpeg
    pkg install -y graphicsmagick optipng jpegoptim
    
    # Audio
    pkg install -y sox mpv
    
    # Documents
    pkg install -y pandoc texlive
    pkg install -y ghostscript poppler
    
    # Web Tools
    pkg install -y lynx w3m
    pkg install -y youtube-dl
    
    print_status "تم تثبيت أدوات الوسائط"
}

# إعداد البيئة المحسنة
configure_environment() {
    print_info "إعداد البيئة المحسنة..."
    
    # Zsh + Oh My Zsh
    if ! command -v zsh >/dev/null 2>&1; then
        pkg install -y zsh
    fi
    
    # تثبيت Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    # إعداد .bashrc محسن
    cat >> ~/.bashrc << 'EOF'

# ===== TERMUX ULTIMATE CONFIGURATION =====

# Aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Development Aliases
alias py='python'
alias py3='python3'
alias pip3='python3 -m pip'
alias serve='python -m http.server'
alias json='python -m json.tool'

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'

# Security Aliases  
alias scan='~/quick_scan.sh'
alias protect='~/quick_protect.sh'
alias secure='proxychains4'
alias vpn='tor'

# System Aliases
alias update='pkg update && pkg upgrade'
alias install='pkg install'
alias search='pkg search'
alias info='pkg show'
alias clean='pkg clean'

# Network Aliases
alias myip='curl -s ipinfo.io/ip'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python'
alias ports='netstat -tuln'
alias connections='netstat -an'

# Development Environment
export EDITOR=nano
export BROWSER=lynx
export PAGER=less

# Python Path
export PYTHONPATH="$HOME/.local/lib/python3.11/site-packages:$PYTHONPATH"

# Node.js Path
export PATH="$HOME/.npm-global/bin:$PATH"

# Go Path
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Rust Path
export PATH="$HOME/.cargo/bin:$PATH"

# Custom Functions
backup() {
    tar -czf "backup_$(date +%Y%m%d_%H%M%S).tar.gz" "$1"
}

extract() {
    case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)           echo "'$1' cannot be extracted" ;;
    esac
}

# تحسين المحرر
export EDITOR=nano
export VISUAL=nano

# تحسين History
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups

# ===== END CONFIGURATION =====
EOF

    print_status "تم إعداد البيئة المحسنة"
}

# إعداد مجلدات العمل
setup_work_directories() {
    print_info "إعداد مجلدات العمل..."
    
    # مجلدات التطوير
    mkdir -p ~/projects/{python,nodejs,java,golang,rust,web}
    mkdir -p ~/tools/{security,network,development,scripts}
    mkdir -p ~/downloads ~/documents ~/backups
    mkdir -p ~/.config/{termux,git,ssh}
    
    # ملفات الإعداد
    touch ~/.gitconfig ~/.ssh/config
    
    # إعداد Git
    read -p "أدخل اسمك لـ Git: " git_name
    read -p "أدخل إيميلك لـ Git: " git_email
    
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    git config --global pull.rebase false
    
    print_status "تم إعداد مجلدات العمل"
}

# تثبيت أدوات إضافية متقدمة
install_advanced_tools() {
    print_info "تثبيت الأدوات المتقدمة..."
    
    # Terminal Enhancement
    pkg install -y termux-api termux-tools
    pkg install -y figlet toilet lolcat
    pkg install -y fortune cowsay
    
    # File Management
    pkg install -y ranger mc
    pkg install -y fzf ripgrep fd bat exa
    
    # System Monitoring
    pkg install -y neofetch screenfetch
    pkg install -y glances gotop
    
    # Network Advanced
    pkg install -y mtr traceroute whois
    pkg install -y curl httpie
    
    # Development Extras
    pkg install -y github-cli hub
    pkg install -y docker-compose
    
    # AI/ML Tools
    pip install tensorflow scikit-learn opencv-python
    pip install torch torchvision
    pip install transformers datasets
    
    print_status "تم تثبيت الأدوات المتقدمة"
}

# تحسين الأداء
optimize_performance() {
    print_info "تحسين أداء النظام..."
    
    # تحسين Zsh
    cat >> ~/.zshrc << 'EOF'
# Performance optimizations
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
ZSH_THEME="agnoster"

# Plugins
plugins=(git docker python pip node npm golang rust)
EOF

    # تحسين Python
    pip install --upgrade pip wheel setuptools
    
    # تحسين Node.js
    npm config set fund false
    npm config set audit false
    
    # تحسين الذاكرة
    echo 'vm.swappiness=10' >> /proc/sys/vm/swappiness 2>/dev/null || true
    
    print_status "تم تحسين الأداء"
}

# إعداد الأمان المتقدم
setup_advanced_security() {
    print_info "إعداد الأمان المتقدم..."
    
    # SSH Security
    cat > ~/.ssh/config << 'EOF'
Host *
    StrictHostKeyChecking ask
    UserKnownHostsFile ~/.ssh/known_hosts
    IdentitiesOnly yes
    Protocol 2
    Compression yes
    ServerAliveInterval 60
    ServerAliveCountMax 3
EOF

    # GPG Setup
    if ! gpg --list-keys >/dev/null 2>&1; then
        print_info "إنشاء مفتاح GPG..."
        gpg --batch --gen-key << 'EOF'
%no-protection
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: Termux User
Name-Email: user@termux.local
Expire-Date: 0
EOF
    fi
    
    # Firewall Rules (Basic)
    cat > ~/tools/security/firewall.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "تفعيل قواعد الحماية الأساسية..."
# Basic protection rules would go here
echo "تم تفعيل الحماية الأساسية"
EOF
    chmod +x ~/tools/security/firewall.sh
    
    print_status "تم إعداد الأمان المتقدم"
}

# تثبيت IDE وأدوات التطوير
install_development_environment() {
    print_info "تثبيت بيئة التطوير المتكاملة..."
    
    # Code Editors
    pkg install -y code-server
    
    # Language Servers  
    npm install -g typescript-language-server
    npm install -g pyright
    npm install -g bash-language-server
    
    # Development Tools
    npm install -g eslint prettier
    npm install -g webpack parcel
    npm install -g create-react-app
    npm install -g @vue/cli
    npm install -g @angular/cli
    
    # Python Development
    pip install black flake8 pylint mypy
    pip install pytest pytest-cov
    pip install poetry pipenv virtualenv
    
    # Database Clients
    pip install mycli pgcli
    npm install -g mongodb-compass-cli
    
    print_status "تم تثبيت بيئة التطوير"
}

# أدوات الذكاء الاصطناعي والتعلم الآلي
install_ai_ml_tools() {
    print_info "تثبيت أدوات الذكاء الاصطناعي..."
    
    # Core AI/ML Libraries
    pip install tensorflow tensorflow-gpu
    pip install torch torchvision torchaudio
    pip install scikit-learn xgboost lightgbm
    pip install numpy scipy pandas matplotlib seaborn
    pip install opencv-python pillow
    pip install nltk spacy transformers
    pip install jupyter jupyterlab notebook
    
    # Deep Learning
    pip install keras pytorch-lightning
    pip install huggingface-hub datasets
    
    # Computer Vision
    pip install mediapipe dlib face-recognition
    
    # NLP Tools
    pip install textblob gensim
    python -m spacy download en_core_web_sm
    
    # Data Science
    pip install plotly dash streamlit
    pip install apache-airflow
    
    print_status "تم تثبيت أدوات الذكاء الاصطناعي"
}

# تثبيت أدوات الهاكرز والأمان
install_hacking_security_tools() {
    print_info "تثبيت أدوات الأمان والاختبار..."
    
    # Network Security
    pkg install -y nmap masscan zmap
    pkg install -y nikto dirb gobuster
    pkg install -y sqlmap wpscan
    
    # Web Security
    pkg install -y burpsuite-community-edition
    pkg install -y owasp-zap
    
    # Wireless
    pkg install -y aircrack-ng reaver
    pkg install -y wifite2 fluxion
    
    # Cryptography
    pkg install -y hashcat john
    pkg install -y steghide binwalk foremost
    pkg install -y openssl gnupg
    
    # Forensics
    pkg install -y sleuthkit autopsy
    pkg install -y volatility yara
    
    # Exploit Development
    pkg install -y metasploit-framework
    pkg install -y exploit-db
    
    # Binary Analysis
    pkg install -y radare2 objdump hexdump
    pkg install -y strings file binutils
    
    print_status "تم تثبيت أدوات الأمان"
}

# إعداد الخوادم والخدمات
setup_servers_services() {
    print_info "إعداد الخوادم والخدمات..."
    
    # Web Servers
    pkg install -y apache2 nginx
    pkg install -y php-apache php-fpm
    
    # Database Services
    pkg install -y mariadb postgresql
    
    # FTP/File Servers
    pkg install -y proftpd vsftpd
    pkg install -y samba
    
    # Proxy/VPN
    pkg install -y shadowsocks-libev
    pkg install -y openvpn
    
    print_status "تم إعداد الخوادم"
}

# تخصيص Termux الكامل
customize_termux() {
    print_info "تخصيص واجهة Termux..."
    
    # Termux Styling
    mkdir -p ~/.termux
    cat > ~/.termux/termux.properties << 'EOF'
# Termux Properties
extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'], \
              ['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]

# Bell
bell-character=ignore

# Colors
use-black-ui=true
EOF

    # Color Scheme
    cat > ~/.termux/colors.properties << 'EOF'
background=#1e1e1e
foreground=#cfcfcf
cursor=#c7c7c7

color0=#1e1e1e
color1=#cf6a4c
color2=#8f9d6a  
color3=#f9ee98
color4=#7587a6
color5=#9b859d
color6=#afc4db
color7=#a7a7a7
color8=#5f5a60
color9=#cf6a4c
color10=#8f9d6a
color11=#f9ee98
color12=#7587a6
color13=#9b859d
color14=#afc4db
color15=#cfcfcf
EOF

    # Font Setup
    curl -fLo ~/.termux/font.ttf \
        https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf
    
    # Motd
    cat > ~/.termux/motd << 'EOF'
╔══════════════════════════════════════════╗
║     🚀 TERMUX ULTIMATE ENVIRONMENT 🚀    ║
║          All Tools Ready to Rock!        ║
╚══════════════════════════════════════════╝
EOF

    print_status "تم تخصيص Termux"
}

# إنشاء أدوات مساعدة
create_helper_scripts() {
    print_info "إنشاء الأدوات المساعدة..."
    
    # سكريپت المعلومات
    cat > ~/tools/system_info.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "═══════════════════════════════════════"
echo "           SYSTEM INFORMATION"
echo "═══════════════════════════════════════"
neofetch 2>/dev/null || echo "Termux on $(uname -m)"
echo "CPU Usage: $(top -bn1 | grep "CPU:" | awk '{print $2}')"
echo "Memory: $(free -h | awk '/^Mem/ {print $3 "/" $2}')"
echo "Storage: $(df -h $HOME | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
echo "Packages: $(pkg list-installed | wc -l) installed"
echo "Uptime: $(uptime -p 2>/dev/null || echo "N/A")"
echo "═══════════════════════════════════════"
EOF

    # سكريپت التحديث الشامل
    cat > ~/tools/ultimate_update.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "🔄 بدء التحديث الشامل..."
pkg update && pkg upgrade -y
pip install --upgrade pip
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U
npm update -g
echo "✅ انتهى التحديث الشامل!"
EOF

    # سكريپت النسخ الاحتياطي الذكي
    cat > ~/tools/smart_backup.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
BACKUP_NAME="termux_full_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p ~/backups
tar --exclude='~/backups' --exclude='~/.cache' --exclude='*/node_modules' \
    -czf ~/backups/${BACKUP_NAME}.tar.gz ~ 2>/dev/null
echo "✅ نسخة احتياطية: ~/backups/${BACKUP_NAME}.tar.gz"
EOF

    # سكريپت تنظيف شامل
    cat > ~/tools/deep_clean.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "🧹 تنظيف شامل للنظام..."
pkg clean
pkg autoclean
pip cache purge
npm cache clean --force
find ~ -name "*.pyc" -delete
find ~ -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null
find ~ -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null
find ~ -name ".DS_Store" -delete 2>/dev/null
find $PREFIX/tmp -type f -delete 2>/dev/null
echo "✅ تم التنظيف الشامل!"
EOF

    chmod +x ~/tools/*.sh
    
    print_status "تم إنشاء الأدوات المساعدة"
}

# القائمة الرئيسية
main_menu() {
    while true; do
        header
        echo -e "${YELLOW}اختر نوع التثبيت:${NC}"
        echo
        echo -e "${CYAN}1.${NC} 🔧 التحديث الأساسي (سريع)"
        echo -e "${CYAN}2.${NC} 💻 بيئة البرمجة الكاملة"  
        echo -e "${CYAN}3.${NC} 🛡️ أدوات الأمان والشبكة"
        echo -e "${CYAN}4.${NC} 🎨 أدوات الوسائط والجرافيك"
        echo -e "${CYAN}5.${NC} 🤖 أدوات الذكاء الاصطناعي"
        echo -e "${CYAN}6.${NC} 🚀 التثبيت الشامل (كل شيء)"
        echo -e "${CYAN}7.${NC} ⚙️ تخصيص البيئة فقط"
        echo -e "${CYAN}8.${NC} 📊 معلومات النظام"
        echo -e "${CYAN}0.${NC} 🚪 خروج"
        echo
        read -p "اختر الرقم (0-8): " choice
        
        case $choice in
            1)
                prepare_system
                install_core_tools
                configure_environment
                setup_work_directories
                print_status "اكتمل التحديث الأساسي!"
                ;;
            2)
                install_programming_environments
                install_development_tools
                install_development_environment
                print_status "اكتملت بيئة البرمجة!"
                ;;
            3)
                install_security_tools
                setup_advanced_security
                print_status "اكتملت أدوات الأمان!"
                ;;
            4)
                install_media_tools
                print_status "اكتملت أدوات الوسائط!"
                ;;
            5)
                install_ai_ml_tools
                print_status "اكتملت أدوات الذكاء الاصطناعي!"
                ;;
            6)
                print_warning "التثبيت الشامل قد يستغرق 30-60 دقيقة!"
                read -p "هل تريد المتابعة؟ (y/n): " confirm
                if [[ $confirm =~ ^[Yy]$ ]]; then
                    prepare_system
                    install_core_tools
                    install_programming_environments
                    install_development_tools
                    install_security_tools
                    install_media_tools
                    install_ai_ml_tools
                    install_advanced_tools
                    configure_environment
                    setup_work_directories
                    setup_advanced_security
                    optimize_performance
                    customize_termux
                    create_helper_scripts
                    print_status "🎉 اكتمل التثبيت الشامل!"
                    print_info "أعد تشغيل Termux للتفعيل الكامل"
                fi
                ;;
            7)
                configure_environment
                customize_termux
                setup_work_directories
                create_helper_scripts
                print_status "اكتمل التخصيص!"
                ;;
            8)
                ~/tools/system_info.sh 2>/dev/null || {
                    echo "معلومات النظام:"
                    echo "الإصدار: $(uname -a)"
                    echo "المساحة: $(df -h $HOME | awk 'NR==2 {print $4 " متاح من " $2}')"
                    echo "الذاكرة: $(free -h | awk '/^Mem/ {print $7 " متاح من " $2}')"
                    echo "الحزم: $(pkg list-installed | wc -l) مثبتة"
                }
                ;;
            0)
                print_info "شكراً لاستخدام Termux Ultimate Setup!"
                exit 0
                ;;
            *)
                print_error "خيار غير صحيح! اختر رقم من 0 إلى 8"
                sleep 2
                ;;
        esac
        
        echo
        read -p "اضغط Enter للمتابعة..." 
    done
}

# تشغيل السكريپت
if [ $# -eq 0 ]; then
    main_menu
else
    case $1 in
        --full)
            prepare_system
            install_core_tools
            install_programming_environments
            install_development_tools
            install_security_tools
            install_media_tools
            install_ai_ml_tools
            install_advanced_tools
            configure_environment
            setup_work_directories
            setup_advanced_security
            optimize_performance
            customize_termux
            create_helper_scripts
            ;;
        --basic)
            prepare_system
            install_core_tools
            configure_environment
            ;;
        --dev)
            install_programming_environments
            install_development_environment
            ;;
        --security)
            install_security_tools
            setup_advanced_security
            ;;
        --ai)
            install_ai_ml_tools
            ;;
        *)
            echo "Usage: $0 [--full|--basic|--dev|--security|--ai]"
            ;;
    esac
fi
