#!/bin/bash

# ═══════════════════════════════════════════════════════════════
# 🛡️ GITIGNORE FORTRESS GENERATOR
# النسخة: 1.0.0
# التاريخ: 2025-10-23
# المطور: المارد الرقمي - Al-Mared Al-Raqami
# الوصف: مولد .gitignore احترافي - ما يعدي نملة! 🐜
# ═══════════════════════════════════════════════════════════════

# الألوان
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# الرموز
SHIELD="🛡️"
LOCK="🔒"
CHECK="✅"
CROSS="❌"
WARNING="⚠️"
ANT="🐜"
FIRE="🔥"
ROCKET="🚀"
EYE="👁️"

GITIGNORE_FILE=".gitignore"

# ═══════════════════════════════════════════════════════════════
# 🎨 دوال العرض
# ═══════════════════════════════════════════════════════════════

print_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║   ██████╗ ██╗████████╗██╗ ██████╗ ███╗   ██╗ ██████╗ ██████╗ ║
║  ██╔════╝ ██║╚══██╔══╝██║██╔════╝ ████╗  ██║██╔═══██╗██╔══██╗║
║  ██║  ███╗██║   ██║   ██║██║  ███╗██╔██╗ ██║██║   ██║██████╔╝║
║  ██║   ██║██║   ██║   ██║██║   ██║██║╚██╗██║██║   ██║██╔══██╗║
║  ╚██████╔╝██║   ██║   ██║╚██████╔╝██║ ╚████║╚██████╔╝██║  ██║║
║   ╚═════╝ ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝║
║                                                               ║
║     ███████╗ ██████╗ ██████╗ ████████╗██████╗ ███████╗███████╗║
║     ██╔════╝██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔════╝██╔════╝║
║     █████╗  ██║   ██║██████╔╝   ██║   ██████╔╝█████╗  ███████╗║
║     ██╔══╝  ██║   ██║██╔══██╗   ██║   ██╔══██╗██╔══╝  ╚════██║║
║     ██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║███████╗███████║║
║     ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo -e "${WHITE}        ${ANT} .gitignore Generator - ما يعدي نملة! ${ANT}${NC}"
    echo -e "${PURPLE}              المارد الرقمي - Al-Mared Al-Raqami${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}\n"
}

print_success() {
    echo -e "${GREEN}${CHECK} $1${NC}"
}

print_error() {
    echo -e "${RED}${CROSS} $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}${WARNING} $1${NC}"
}

print_info() {
    echo -e "${BLUE}${EYE} $1${NC}"
}

# ═══════════════════════════════════════════════════════════════
# 📝 دالة إنشاء .gitignore الكامل والشامل
# ═══════════════════════════════════════════════════════════════

create_ultimate_gitignore() {
    print_info "جاري إنشاء .gitignore فائق الحماية..."
    
    cat > "$GITIGNORE_FILE" << 'EOF'
# ═══════════════════════════════════════════════════════════════
# 🛡️ GITIGNORE FORTRESS - Ultimate Protection
# التاريخ: 2025-10-23
# المطور: المارد الرقمي - Al-Mared Al-Raqami
# الوصف: ملف .gitignore احترافي - حماية شاملة 360 درجة
# 🐜 ما يعدي نملة!
# ═══════════════════════════════════════════════════════════════

# ═══════════════════════════════════════════════════════════════
# 🔐 1. SECURITY & CREDENTIALS - الأمان وبيانات الاعتماد
# ═══════════════════════════════════════════════════════════════

# Environment Variables
.env
.env.*
.env.local
.env.production
.env.development
.env.test
.env.staging
*.env
env.sh
environment.sh

# API Keys & Secrets
*secret*
*SECRET*
*apikey*
*api_key*
*API_KEY*
credentials.json
secrets.yaml
secrets.yml
config/secrets.*
vault.json
*.pem
*.key
*.crt
*.cer
*.p12
*.pfx
*.keystore
*.jks

# AWS Credentials
.aws/
aws-credentials
aws-config
*.aws

# SSH & GPG Keys
id_rsa
id_rsa.*
id_dsa
id_dsa.*
id_ecdsa
id_ecdsa.*
id_ed25519
id_ed25519.*
*.ppk
*.pub
.ssh/
known_hosts
authorized_keys
*.gpg
*.asc

# Database Credentials
database.yml
database.ini
*.sql
*.sqlite
*.sqlite3
*.db
db_credentials
mysql_credentials
postgres_credentials

# Cloud Provider Secrets
gcloud/
.gcp/
.azure/
digitalocean/
heroku/

# OAuth & Tokens
oauth_token
access_token
refresh_token
auth_token
*.token
jwt_secret

# ═══════════════════════════════════════════════════════════════
# 💻 2. OPERATING SYSTEMS - أنظمة التشغيل
# ═══════════════════════════════════════════════════════════════

# Windows
Thumbs.db
Thumbs.db:encryptable
ehthumbs.db
ehthumbs_vista.db
*.stackdump
[Dd]esktop.ini
$RECYCLE.BIN/
*.cab
*.msi
*.msix
*.msm
*.msp
*.lnk
*.sys
*.swp
*.tmp
*.temp
*.log
*.bak
*.old
*~

# macOS
.DS_Store
.AppleDouble
.LSOverride
Icon
._*
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk
*.dmg

# Linux
*~
.directory
.Trash-*
.nfs*
*.core

# ═══════════════════════════════════════════════════════════════
# 🛠️ 3. IDEs & EDITORS - بيئات التطوير والمحررات
# ═══════════════════════════════════════════════════════════════

# Visual Studio Code
.vscode/
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
*.code-workspace
.history/
.ionide/

# JetBrains IDEs (IntelliJ, PyCharm, WebStorm, etc.)
.idea/
.idea/*
*.iml
*.iws
*.ipr
out/
.idea_modules/
atlassian-ide-plugin.xml
com_crashlytics_export_strings.xml
crashlytics.properties
crashlytics-build.properties
fabric.properties

# Sublime Text
*.sublime-workspace
*.sublime-project
*.tmlanguage.cache
*.tmPreferences.cache
*.stTheme.cache
*.sublime-workspace

# Vim
[._]*.s[a-v][a-z]
[._]*.sw[a-p]
[._]s[a-rt-v][a-z]
[._]ss[a-gi-z]
[._]sw[a-p]
Session.vim
Sessionx.vim
.netrwhist
tags
[._]*.un~

# Emacs
*~
\#*\#
/.emacs.desktop
/.emacs.desktop.lock
*.elc
auto-save-list
tramp
.\#*

# Atom
.atom/

# Eclipse
.metadata
bin/
tmp/
*.tmp
*.bak
*.swp
*~.nib
local.properties
.settings/
.loadpath
.recommenders
.project
.classpath
.c9/
*.launch
.buildpath
.target
.tern-project
.texlipse
.springBeans
.recommenders/
.apt_generated/
.apt_generated_test/
.factorypath
.cache-main
.scala_dependencies
.worksheet

# NetBeans
/nbproject/private/
/nbbuild/
/dist/
/nbdist/
/.nb-gradle/
build/

# Xcode
xcuserdata/
*.xcscmblueprint
*.xccheckout
*.moved-aside
*.xcuserstate
*.xcworkspace

# ═══════════════════════════════════════════════════════════════
# 📦 4. PACKAGE MANAGERS & DEPENDENCIES - مدراء الحزم
# ═══════════════════════════════════════════════════════════════

# Node.js / NPM / Yarn
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
.pnpm-debug.log*
.npm
.eslintcache
.node_repl_history
*.tgz
.yarn-integrity
.yarn/cache
.yarn/unplugged
.yarn/build-state.yml
.yarn/install-state.gz
.pnp.*
package-lock.json
yarn.lock
pnpm-lock.yaml

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST
pip-log.txt
pip-delete-this-directory.txt
.venv
venv/
ENV/
env/
env.bak/
venv.bak/
.pyenv
Pipfile.lock
poetry.lock
.pytest_cache/
.mypy_cache/
.dmypy.json
dmypy.json
.pyre/
.pytype/
.coverage
.coverage.*
htmlcov/
.tox/
.nox/

# Ruby
*.gem
*.rbc
/.config
/coverage/
/InstalledFiles
/pkg/
/spec/reports/
/spec/examples.txt
/test/tmp/
/test/version_tmp/
/tmp/
*.log
.rvmrc
/.bundle/
/vendor/bundle
/lib/bundler/man/
Gemfile.lock

# PHP / Composer
/vendor/
composer.lock
composer.phar
*.cache
.phpunit.result.cache

# Java / Maven / Gradle
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties
.mvn/timing.properties
.mvn/wrapper/maven-wrapper.jar
.gradle
**/build/
!src/**/build/
gradle-app.setting
!gradle-wrapper.jar
.gradletasknamecache

# Go
*.exe
*.exe~
*.dll
*.so
*.dylib
*.test
*.out
go.work
vendor/

# Rust
/target/
**/*.rs.bk
Cargo.lock

# .NET / C#
[Bb]in/
[Oo]bj/
[Ll]og/
[Ll]ogs/
*.user
*.userosscache
*.sln.docstates
*.suo
*.cache
project.lock.json
project.fragment.lock.json
artifacts/
*_i.c
*_p.c
*_h.h
*.ilk
*.meta
*.obj
*.iobj
*.pch
*.pdb
*.ipdb
*.pgc
*.pgd
*.rsp
*.sbr
*.tlb
*.tli
*.tlh
*.tmp
*.tmp_proj
*_wpftmp.csproj
*.vspscc
*.vssscc
.builds
*.pidb
*.svclog
*.scc

# ═══════════════════════════════════════════════════════════════
# 🌐 5. WEB DEVELOPMENT - تطوير الويب
# ═══════════════════════════════════════════════════════════════

# Build outputs
dist/
build/
.next/
out/
.nuxt/
.cache/
.parcel-cache/
.docusaurus/
public/build/
*.min.js
*.min.css

# Static site generators
.jekyll-cache/
.jekyll-metadata
_site/
.gatsby/
.hugo_build.lock

# CSS Preprocessors
.sass-cache/
*.css.map
*.sass.map
*.scss.map

# Testing
coverage/
.nyc_output/
*.lcov
test-results/
playwright-report/
.playwright/
cypress/videos/
cypress/screenshots/

# Logs
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

# ═══════════════════════════════════════════════════════════════
# 🐳 6. CONTAINERIZATION & VIRTUALIZATION - الحاويات والأجهزة الوهمية
# ═══════════════════════════════════════════════════════════════

# Docker
.dockerignore
docker-compose.override.yml
.docker/
*.dockerignore

# Vagrant
.vagrant/
*.box

# Virtual Machines
*.vdi
*.vhd
*.vmdk
*.vmx
*.vmxf
*.vmwarevm
*.ovf
*.ova

# ═══════════════════════════════════════════════════════════════
# 📱 7. MOBILE DEVELOPMENT - تطوير تطبيقات الموبايل
# ═══════════════════════════════════════════════════════════════

# Android
*.apk
*.aab
*.ap_
*.dex
.gradle
local.properties
.idea/
*.iml
.externalNativeBuild
.cxx
output.json
captures/
.navigation/
lint/
*.hprof

# iOS
*.ipa
*.dSYM.zip
*.dSYM
DerivedData/
*.pbxuser
!default.pbxuser
*.mode1v3
!default.mode1v3
*.mode2v3
!default.mode2v3
*.perspectivev3
!default.perspectivev3
*.hmap
*.ipa
*.xcuserstate
ios/.xcode.env.local
Pods/
Podfile.lock

# React Native
.expo/
.expo-shared/
metro-cache/

# Flutter
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/
flutter_*.png
flutter_export_environment.sh

# ═══════════════════════════════════════════════════════════════
# 💾 8. DATABASES - قواعد البيانات
# ═══════════════════════════════════════════════════════════════

*.sql
*.sqlite
*.sqlite3
*.db
*.db-shm
*.db-wal
*.mdb
*.accdb
*.dbf
*.dmp
*.backup
*.bak
mysql-data/
postgres-data/
mongodb-data/
redis-data/
*.rdb
dump.rdb

# ═══════════════════════════════════════════════════════════════
# 📊 9. ANALYTICS & MONITORING - التحليلات والمراقبة
# ═══════════════════════════════════════════════════════════════

# Google Analytics
gtag.js
analytics.js

# Monitoring
newrelic.ini
.sentry/
*.trace
*.prof

# Performance
*.trace
*.cpuprofile
*.heapprofile
*.heapsnapshot

# ═══════════════════════════════════════════════════════════════
# 🔧 10. BUILD TOOLS & CI/CD - أدوات البناء
# ═══════════════════════════════════════════════════════════════

# Webpack
.webpack/
webpack.*.js
webpack-stats.json

# Rollup
rollup.config.*.js

# Vite
vite.config.*.timestamp-*

# Turbo
.turbo/

# CI/CD
.gitlab-ci-local/
.circleci/
.travis/
.github/workflows/*-local.yml

# ═══════════════════════════════════════════════════════════════
# 📝 11. DOCUMENTATION & GENERATED FILES - الوثائق والملفات المولدة
# ═══════════════════════════════════════════════════════════════

# Documentation
docs/_build/
site/
.docusaurus/
.vuepress/dist
.vuepress/.temp
.vuepress/.cache

# Generated files
*.generated.*
*.auto.*
*.autogenerated.*
*-generated/
auto-generated/

# ═══════════════════════════════════════════════════════════════
# 🎮 12. MULTIMEDIA & ASSETS - الوسائط المتعددة
# ═══════════════════════════════════════════════════════════════

# Large media files (optional - uncomment if needed)
# *.mp4
# *.mov
# *.avi
# *.mkv
# *.flv
# *.mp3
# *.wav
# *.flac
# *.psd
# *.ai
# *.sketch

# Thumbnails
*-thumb.*
*-thumbnail.*
thumbs/

# ═══════════════════════════════════════════════════════════════
# 🗜️ 13. ARCHIVES & COMPRESSED FILES - الأرشيف والملفات المضغوطة
# ═══════════════════════════════════════════════════════════════

*.zip
*.tar
*.tar.gz
*.tgz
*.rar
*.7z
*.gz
*.bz2
*.xz
*.iso
*.jar
*.war
*.ear
*.sar
*.class

# ═══════════════════════════════════════════════════════════════
# 🔍 14. SEARCH & INDEX FILES - ملفات البحث والفهرسة
# ═══════════════════════════════════════════════════════════════

*.idx
*.index
*.search
.elasticbeanstalk/
.solr/
elasticsearch-data/

# ═══════════════════════════════════════════════════════════════
# 🌍 15. LOCALIZATION & TRANSLATIONS - الترجمة والتعريب
# ═══════════════════════════════════════════════════════════════

*.mo
*.pot
.translation-cache/

# ═══════════════════════════════════════════════════════════════
# 🧪 16. TESTING & QA - الاختبارات وضمان الجودة
# ═══════════════════════════════════════════════════════════════

# Test outputs
test-results/
test-output/
coverage/
.coverage
htmlcov/
*.cover
.hypothesis/
.pytest_cache/
.jest/
karma-results/
__snapshots__/
*.test.js.snap

# E2E Testing
screenshots/
videos/
reports/

# ═══════════════════════════════════════════════════════════════
# 💼 17. BUSINESS & LEGAL - الأعمال والقانون
# ═══════════════════════════════════════════════════════════════

# Contracts & Legal
contracts/
legal/
NDA/
*.contract
*.agreement

# Financial
invoices/
receipts/
*.invoice
financial-reports/

# ═══════════════════════════════════════════════════════════════
# 🛡️ 18. SECURITY SCANS & REPORTS - فحوصات الأمان والتقارير
# ═══════════════════════════════════════════════════════════════

# Security Reports
security-reports/
vulnerability-scan/
*.security
*.vuln
.snyk
trivy-report/
*.sarif

# ═══════════════════════════════════════════════════════════════
# 🎯 19. PROJECT SPECIFIC - خاص بالمشروع
# ═══════════════════════════════════════════════════════════════

# Backup files
*.backup
*.bak
*.old
*-old
*-backup
backup/
backups/

# Temporary files
tmp/
temp/
*.tmp
*.temp
.temporary/

# Cache
cache/
.cache/
*.cache

# Local configuration
*.local
local/
.local/
config.local.*
settings.local.*

# Notes & Documentation
TODO
TODO.md
NOTES
NOTES.md
notes/
.notes/
scratch/
drafts/

# ═══════════════════════════════════════════════════════════════
# 🚀 20. DEPLOYMENT & PRODUCTION - النشر والإنتاج
# ═══════════════════════════════════════════════════════════════

# Production config
.prod/
production/
*.production
prod-config/

# Deployment
deploy/
deployment/
.deploy/
*.deploy

# CDN
cdn/
.cdn/

# ═══════════════════════════════════════════════════════════════
# 🎓 21. EDUCATIONAL & TUTORIALS - تعليمي ودروس
# ═══════════════════════════════════════════════════════════════

# Practice files
practice/
sandbox/
playground/
examples/local/
test-projects/

# ═══════════════════════════════════════════════════════════════
# 🔐 22. CUSTOM SECURITY FORTRESS - حماية خاصة إضافية
# ═══════════════════════════════════════════════════════════════

# Personal Information
personal/
private/
confidential/
sensitive/
*-sensitive.*
*-private.*
*-confidential.*

# Internal Tools
internal/
internal-tools/
admin-panel/
admin/

# Experimental
experimental/
experiments/
lab/
research/

# Development only
dev-only/
development-only/
*.dev-only.*

# ═══════════════════════════════════════════════════════════════
# 📌 23. MISCELLANEOUS - متفرقات
# ═══════════════════════════════════════════════════════════════

# System files
.system/
*.sys
*.pid
*.seed
*.pid.lock

# Ignore everything in root except specific files
# (Uncomment and customize if needed)
# /*
# !README.md
# !LICENSE
# !.gitignore

# ═══════════════════════════════════════════════════════════════
# ✅ END OF GITIGNORE FORTRESS
# 🛡️ حماية كاملة 360 درجة
# 🐜 لا يعدي نملة!
# المارد الرقمي - Al-Mared Al-Raqami
# ═══════════════════════════════════════════════════════════════
EOF

    if [ -f "$GITIGNORE_FILE" ]; then
        print_success "تم إنشاء .gitignore بنجاح!"
        return 0
    else
        print_error "فشل في إنشاء .gitignore"
        return 1
    fi
}

# ═══════════════════════════════════════════════════════════════
# 📊 دالة عرض إحصائيات الحماية
# ═══════════════════════════════════════════════════════════════

show_stats() {
    if [ ! -f "$GITIGNORE_FILE" ]; then
        print_error "ملف .gitignore غير موجود!"
        return 1
    fi
    
    echo -e "\n${CYAN}════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}       📊 إحصائيات الحماية${NC}"
    echo -e "${CYAN}════════════════════════════════════════════════${NC}\n"
    
    local total_lines=$(wc -l < "$GITIGNORE_FILE")
    local rules=$(grep -v "^#" "$GITIGNORE_FILE" | grep -v "^$" | wc -l)
    local categories=$(grep "^# ═" "$GITIGNORE_FILE" | wc -l)
    
    echo -e "${GREEN}${SHIELD} إجمالي الأسطر:${NC} ${WHITE}$total_lines${NC}"
    echo -e "${GREEN}${LOCK} قواعد الحماية:${NC} ${WHITE}$rules${NC}"
    echo -e "${GREEN}${FIRE} التصنيفات:${NC} ${WHITE}$categories${NC}"
    
    echo -e "\n${YELLOW}${WARNING} المحمي:${NC}"
    echo -e "  ${CHECK} بيانات الاعتماد والأسرار"
    echo -e "  ${CHECK} ملفات أنظمة التشغيل"
    echo -e "  ${CHECK} بيئات التطوير والمحررات"
    echo -e "  ${CHECK} مدراء الحزم والتبعيات"
    echo -e "  ${CHECK} ملفات البناء والتجميع"
    echo -e "  ${CHECK} قواعد البيانات"
    echo -e "  ${CHECK} الملفات المؤقتة والنسخ الاحتياطية"
    echo -e "  ${CHECK} السجلات والتقارير"
    echo -e "  ${CHECK} المعلومات الحساسة"
    echo -e "  ${CHECK} وأكثر من 23 فئة حماية!"
    
    echo -e "\n${GREEN}${ANT} الوضع: لا يعدي نملة! ${ANT}${NC}"
    echo -e "${CYAN}════════════════════════════════════════════════${NC}\n"
}

# ═══════════════════════════════════════════════════════════════
# 🔍 دالة التحقق من الملفات المكشوفة
# ═══════════════════════════════════════════════════════════════

check_exposed_files() {
    print_info "جاري فحص الملفات المكشوفة..."
    
    local exposed=0
    local dangerous_files=(
        ".env"
        ".env.local"
        "credentials.json"
        "secrets.yaml"
        "id_rsa"
        "*.pem"
        "*.key"
        "database.yml"
        "config/secrets.yml"
    )
    
    echo -e "\n${YELLOW}${WARNING} فحص الملفات الحساسة:${NC}\n"
    
    for pattern in "${dangerous_files[@]}"; do
        if ls $pattern 2>/dev/null | grep -q .; then
            print_error "تحذير: تم العثور على ملف حساس: $pattern"
            ((exposed++))
        fi
    done
    
    if [ $exposed -eq 0 ]; then
        print_success "ممتاز! لا توجد ملفات حساسة مكشوفة"
    else
        print_warning "تم العثور على $exposed ملف حساس! يجب حمايتها"
    fi
    
    echo ""
}

# ═══════════════════════════════════════════════════════════════
# 🎯 دالة إضافة قواعد مخصصة
# ═══════════════════════════════════════════════════════════════

add_custom_rules() {
    echo -e "\n${CYAN}════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}       ➕ إضافة قواعد مخصصة${NC}"
    echo -e "${CYAN}════════════════════════════════════════════════${NC}\n"
    
    echo -e "${YELLOW}أدخل القواعد المخصصة (سطر واحد لكل قاعدة):${NC}"
    echo -e "${BLUE}اكتب 'done' للانتهاء${NC}\n"
    
    if [ ! -f "$GITIGNORE_FILE" ]; then
        print_error "يجب إنشاء .gitignore أولاً!"
        return 1
    fi
    
    echo -e "\n# ═══════════════════════════════════════════════════════════════" >> "$GITIGNORE_FILE"
    echo "# 🎯 24. CUSTOM RULES - قواعد مخصصة" >> "$GITIGNORE_FILE"
    echo "# ═══════════════════════════════════════════════════════════════" >> "$GITIGNORE_FILE"
    echo "" >> "$GITIGNORE_FILE"
    
    local count=0
    while true; do
        echo -ne "${GREEN}➜${NC} "
        read rule
        
        if [ "$rule" = "done" ] || [ "$rule" = "Done" ] || [ "$rule" = "DONE" ]; then
            break
        fi
        
        if [ -n "$rule" ]; then
            echo "$rule" >> "$GITIGNORE_FILE"
            print_success "تمت إضافة: $rule"
            ((count++))
        fi
    done
    
    if [ $count -gt 0 ]; then
        print_success "تمت إضافة $count قاعدة مخصصة بنجاح!"
    else
        print_warning "لم يتم إضافة أي قواعد"
    fi
}

# ═══════════════════════════════════════════════════════════════
# 🧹 دالة تنظيف Git Cache
# ═══════════════════════════════════════════════════════════════

clean_git_cache() {
    echo -e "\n${CYAN}════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}       🧹 تنظيف Git Cache${NC}"
    echo -e "${CYAN}════════════════════════════════════════════════${NC}\n"
    
    if [ ! -d ".git" ]; then
        print_error "هذا المجلد ليس مستودع Git!"
        return 1
    fi
    
    print_warning "سيتم إزالة جميع الملفات من Git cache وإعادة إضافتها"
    echo -ne "${YELLOW}هل أنت متأكد؟ (y/n): ${NC}"
    read confirm
    
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        print_info "تم الإلغاء"
        return 0
    fi
    
    print_info "جاري تنظيف Git cache..."
    
    # Remove all files from git cache
    git rm -r --cached . 2>/dev/null
    
    # Add all files back respecting .gitignore
    git add .
    
    print_success "تم تنظيف Git cache بنجاح!"
    print_info "يمكنك الآن عمل commit للتغييرات"
}

# ═══════════════════════════════════════════════════════════════
# 🔍 دالة معاينة الملفات المتتبعة
# ═══════════════════════════════════════════════════════════════

preview_tracked_files() {
    echo -e "\n${CYAN}════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}       👁️  معاينة الملفات المتتبعة${NC}"
    echo -e "${CYAN}════════════════════════════════════════════════${NC}\n"
    
    if [ ! -d ".git" ]; then
        print_error "هذا المجلد ليس مستودع Git!"
        return 1
    fi
    
    print_info "الملفات التي سيتم تتبعها:"
    echo ""
    
    # Show files that would be tracked
    git add --dry-run -A 2>/dev/null | head -20
    
    local total=$(git add --dry-run -A 2>/dev/null | wc -l)
    
    if [ $total -gt 20 ]; then
        echo -e "\n${YELLOW}... وأكثر من $total ملف${NC}"
    fi
    
    echo -e "\n${GREEN}إجمالي الملفات:${NC} $total"
}

# ═══════════════════════════════════════════════════════════════
# 💾 دالة النسخ الاحتياطي
# ═══════════════════════════════════════════════════════════════

backup_gitignore() {
    if [ ! -f "$GITIGNORE_FILE" ]; then
        print_error "لا يوجد ملف .gitignore للنسخ الاحتياطي!"
        return 1
    fi
    
    local backup_file=".gitignore.backup.$(date +%Y%m%d_%H%M%S)"
    
    cp "$GITIGNORE_FILE" "$backup_file"
    
    if [ -f "$backup_file" ]; then
        print_success "تم إنشاء نسخة احتياطية: $backup_file"
        return 0
    else
        print_error "فشل في إنشاء النسخة الاحتياطية"
        return 1
    fi
}

# ═══════════════════════════════════════════════════════════════
# 🎨 دالة القائمة الرئيسية
# ═══════════════════════════════════════════════════════════════

show_menu() {
    echo -e "${CYAN}════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}              📋 القائمة الرئيسية${NC}"
    echo -e "${CYAN}════════════════════════════════════════════════${NC}\n"
    
    echo -e "${GREEN}1)${NC} ${FIRE} إنشاء .gitignore كامل احترافي"
    echo -e "${GREEN}2)${NC} ${SHIELD} عرض إحصائيات الحماية"
    echo -e "${GREEN}3)${NC} ${EYE} فحص الملفات المكشوفة"
    echo -e "${GREEN}4)${NC} ${ROCKET} إضافة قواعد مخصصة"
    echo -e "${GREEN}5)${NC} ${LOCK} معاينة الملفات المتتبعة"
    echo -e "${GREEN}6)${NC} ${WARNING} تنظيف Git Cache"
    echo -e "${GREEN}7)${NC} 💾 نسخ احتياطي للـ .gitignore"
    echo -e "${GREEN}8)${NC} ${ANT} تثبيت كامل (الكل)"
    echo -e "${RED}9)${NC} ${CROSS} خروج"
    
    echo -e "\n${CYAN}════════════════════════════════════════════════${NC}"
}

# ═══════════════════════════════════════════════════════════════
# 🚀 دالة التثبيت الكامل
# ═══════════════════════════════════════════════════════════════

full_installation() {
    echo -e "\n${PURPLE}${ROCKET} بدء التثبيت الكامل...${NC}\n"
    sleep 1
    
    # نسخ احتياطي إذا كان موجود
    if [ -f "$GITIGNORE_FILE" ]; then
        print_info "عمل نسخة احتياطية للملف القديم..."
        backup_gitignore
        sleep 1
    fi
    
    # إنشاء .gitignore
    create_ultimate_gitignore
    sleep 1
    
    # عرض الإحصائيات
    show_stats
    sleep 1
    
    # فحص الملفات
    check_exposed_files
    sleep 1
    
    # معاينة الملفات
    if [ -d ".git" ]; then
        preview_tracked_files
    fi
    
    echo -e "\n${GREEN}${ROCKET}${SHIELD} اكتمل التثبيت بنجاح! ${ANT}${NC}"
    echo -e "${PURPLE}الحماية الكاملة نشطة - لا يعدي نملة!${NC}\n"
}

# ═══════════════════════════════════════════════════════════════
# 🎯 البرنامج الرئيسي
# ═══════════════════════════════════════════════════════════════

main() {
    print_banner
    
    # التحقق من وجود git
    if ! command -v git &> /dev/null; then
        print_warning "Git غير مثبت على النظام"
        print_info "بعض الميزات قد لا تعمل"
        echo ""
    fi
    
    while true; do
        show_menu
        echo -ne "\n${YELLOW}اختر رقم من القائمة:${NC} "
        read choice
        
        case $choice in
            1)
                echo ""
                create_ultimate_gitignore
                sleep 2
                print_banner
                ;;
            2)
                show_stats
                read -p "اضغط Enter للمتابعة..."
                print_banner
                ;;
            3)
                check_exposed_files
                read -p "اضغط Enter للمتابعة..."
                print_banner
                ;;
            4)
                add_custom_rules
                sleep 2
                print_banner
                ;;
            5)
                preview_tracked_files
                read -p "اضغط Enter للمتابعة..."
                print_banner
                ;;
            6)
                clean_git_cache
                sleep 2
                print_banner
                ;;
            7)
                echo ""
                backup_gitignore
                sleep 2
                print_banner
                ;;
            8)
                full_installation
                read -p "اضغط Enter للمتابعة..."
                print_banner
                ;;
            9)
                echo -e "\n${GREEN}${SHIELD} شكراً لاستخدامك Gitignore Fortress!${NC}"
                echo -e "${PURPLE}${ANT} لا يعدي نملة! ${ANT}${NC}"
                echo -e "${CYAN}المارد الرقمي - Al-Mared Al-Raqami${NC}\n"
                exit 0
                ;;
            *)
                print_error "اختيار غير صحيح!"
                sleep 1
                print_banner
                ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════════
# 🎬 تشغيل البرنامج
# ═══════════════════════════════════════════════════════════════

# التحقق من الصلاحيات
if [ ! -w "." ]; then
    echo -e "${RED}${CROSS} خطأ: لا توجد صلاحيات الكتابة في المجلد الحالي${NC}"
    exit 1
fi

# تشغيل البرنامج الرئيسي
main
