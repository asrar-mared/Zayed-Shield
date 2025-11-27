#!/bin/bash

# ===========================================
# 🛡️ درع زايد للأمن السيبراني - Security Scan Script
# Zayed Shield - Automated Security Scanning
# ===========================================
#
# Description: Comprehensive security scanning for the project
# Usage: ./scripts/security-scan.sh [options]
# Options:
#   --full          Run full security scan
#   --quick         Run quick scan (default)
#   --deps-only     Only scan dependencies
#   --code-only     Only scan code
#
# Author: Zayed CyberShield Team
# Version: 1.0.0
# ===========================================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_DIR="$PROJECT_ROOT/.security-reports"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
REPORT_FILE="$REPORT_DIR/security_report_$TIMESTAMP.txt"

# Counters
VULNERABILITIES_FOUND=0
WARNINGS_FOUND=0
PASSED_CHECKS=0

# Default options
SCAN_MODE="quick"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --full)
            SCAN_MODE="full"
            shift
            ;;
        --quick)
            SCAN_MODE="quick"
            shift
            ;;
        --deps-only)
            SCAN_MODE="deps"
            shift
            ;;
        --code-only)
            SCAN_MODE="code"
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
    esac
done

# Create report directory
mkdir -p "$REPORT_DIR"

# Initialize report
init_report() {
    {
        echo "═══════════════════════════════════════════════════════════════"
        echo "🛡️ درع زايد - تقرير الفحص الأمني"
        echo "   Zayed Shield - Security Scan Report"
        echo "═══════════════════════════════════════════════════════════════"
        echo ""
        echo "📅 Date: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "📁 Project: $PROJECT_ROOT"
        echo "🔧 Scan Mode: $SCAN_MODE"
        echo ""
        echo "═══════════════════════════════════════════════════════════════"
    } > "$REPORT_FILE"
}

# Logging function
log() {
    local level="$1"
    local message="$2"
    
    echo "$message" >> "$REPORT_FILE"
    
    case $level in
        "PASS")
            echo -e "${GREEN}✅ $message${NC}"
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
            ;;
        "WARN")
            echo -e "${YELLOW}⚠️  $message${NC}"
            WARNINGS_FOUND=$((WARNINGS_FOUND + 1))
            ;;
        "FAIL")
            echo -e "${RED}❌ $message${NC}"
            VULNERABILITIES_FOUND=$((VULNERABILITIES_FOUND + 1))
            ;;
        "INFO")
            echo -e "${BLUE}ℹ️  $message${NC}"
            ;;
        "SECTION")
            echo -e "${CYAN}═══ $message ═══${NC}"
            ;;
    esac
}

# Header display
show_header() {
    echo -e "${BLUE}"
    echo "═══════════════════════════════════════════════════════════════"
    echo "🛡️  درع زايد - الفحص الأمني الشامل"
    echo "    Zayed Shield - Security Scanner"
    echo "═══════════════════════════════════════════════════════════════"
    echo -e "${NC}"
}

# Check for sensitive files
check_sensitive_files() {
    log "SECTION" "Checking for sensitive files"
    echo "" >> "$REPORT_FILE"
    
    local sensitive_patterns=(
        "*.env"
        "*.env.*"
        "*.pem"
        "*.key"
        "*.p12"
        "*credentials*"
        "*secret*"
        ".aws/*"
        ".ssh/*"
    )
    
    local found_sensitive=false
    
    for pattern in "${sensitive_patterns[@]}"; do
        if find "$PROJECT_ROOT" -name "$pattern" -not -path "*/node_modules/*" -not -path "*/.git/*" 2>/dev/null | grep -q .; then
            found_sensitive=true
            log "WARN" "Potentially sensitive file pattern found: $pattern"
        fi
    done
    
    if [ "$found_sensitive" = false ]; then
        log "PASS" "No sensitive files found in repository"
    fi
}

# Check for hardcoded secrets
check_hardcoded_secrets() {
    log "SECTION" "Checking for hardcoded secrets"
    echo "" >> "$REPORT_FILE"
    
    local secret_patterns=(
        "password\s*=\s*['\"][^'\"]+['\"]"
        "api_key\s*=\s*['\"][^'\"]+['\"]"
        "secret\s*=\s*['\"][^'\"]+['\"]"
        "token\s*=\s*['\"][^'\"]+['\"]"
        "AKIA[0-9A-Z]{16}"  # AWS Access Key
        "sk_live_[a-zA-Z0-9]+"  # Stripe
    )
    
    local secrets_found=false
    
    for pattern in "${secret_patterns[@]}"; do
        if grep -rE "$pattern" "$PROJECT_ROOT" \
            --include="*.js" \
            --include="*.ts" \
            --include="*.json" \
            --include="*.yaml" \
            --include="*.yml" \
            --exclude-dir="node_modules" \
            --exclude-dir=".git" 2>/dev/null | head -5 | grep -q .; then
            secrets_found=true
            log "WARN" "Potential hardcoded secret pattern: $pattern"
        fi
    done
    
    if [ "$secrets_found" = false ]; then
        log "PASS" "No hardcoded secrets detected"
    fi
}

# Check dangerous code patterns
check_dangerous_patterns() {
    log "SECTION" "Checking for dangerous code patterns"
    echo "" >> "$REPORT_FILE"
    
    # JavaScript/Node.js patterns
    local js_dangerous=(
        "eval("
        "new Function("
        "child_process.exec"
        "innerHTML\s*="
        "dangerouslySetInnerHTML"
    )
    
    for pattern in "${js_dangerous[@]}"; do
        if grep -r "$pattern" "$PROJECT_ROOT" \
            --include="*.js" \
            --include="*.ts" \
            --include="*.jsx" \
            --include="*.tsx" \
            --exclude-dir="node_modules" \
            --exclude-dir=".git" 2>/dev/null | head -3 | grep -q .; then
            log "WARN" "Dangerous JavaScript pattern found: $pattern"
        fi
    done
    
    # Python patterns
    local py_dangerous=(
        "exec("
        "eval("
        "subprocess.call.*shell=True"
        "os.system("
    )
    
    for pattern in "${py_dangerous[@]}"; do
        if grep -r "$pattern" "$PROJECT_ROOT" \
            --include="*.py" \
            --exclude-dir="node_modules" \
            --exclude-dir=".git" \
            --exclude-dir="venv" 2>/dev/null | head -3 | grep -q .; then
            log "WARN" "Dangerous Python pattern found: $pattern"
        fi
    done
    
    # Shell patterns - note: these patterns are for grep -E extended regex
    local shell_dangerous=(
        'eval "\$'
        '\$\(.*\)'
    )
    
    for pattern in "${shell_dangerous[@]}"; do
        if grep -rE "$pattern" "$PROJECT_ROOT" \
            --include="*.sh" \
            --exclude-dir="node_modules" \
            --exclude-dir=".git" 2>/dev/null | head -3 | grep -q .; then
            log "WARN" "Potentially dangerous shell pattern found"
        fi
    done
    
    log "PASS" "Dangerous code pattern check completed"
}

# Check npm dependencies
check_npm_vulnerabilities() {
    log "SECTION" "Checking npm dependencies for vulnerabilities"
    echo "" >> "$REPORT_FILE"
    
    if [ ! -f "$PROJECT_ROOT/package.json" ]; then
        log "INFO" "No package.json found - skipping npm audit"
        return
    fi
    
    cd "$PROJECT_ROOT"
    
    if [ -d "node_modules" ]; then
        if npm audit --json 2>/dev/null | grep -q '"vulnerabilities"'; then
            local vuln_count
            vuln_count=$(npm audit --json 2>/dev/null | grep -c '"severity"' || echo "0")
            if [ "$vuln_count" -gt 0 ]; then
                log "WARN" "Found $vuln_count potential vulnerabilities in npm dependencies"
                log "INFO" "Run 'npm audit' for details"
            else
                log "PASS" "No known npm vulnerabilities found"
            fi
        else
            log "PASS" "npm audit passed"
        fi
    else
        log "INFO" "node_modules not installed - run npm install first"
    fi
}

# Check file permissions
check_file_permissions() {
    log "SECTION" "Checking file permissions"
    echo "" >> "$REPORT_FILE"
    
    # Check for world-writable files
    local world_writable
    world_writable=$(find "$PROJECT_ROOT" -type f -perm -002 \
        -not -path "*/node_modules/*" \
        -not -path "*/.git/*" 2>/dev/null | wc -l)
    
    if [ "$world_writable" -gt 0 ]; then
        log "WARN" "Found $world_writable world-writable files"
    else
        log "PASS" "No world-writable files found"
    fi
    
    # Check shell scripts have proper permissions
    local shell_scripts
    shell_scripts=$(find "$PROJECT_ROOT" -name "*.sh" \
        -not -path "*/node_modules/*" \
        -not -path "*/.git/*" 2>/dev/null)
    
    local non_exec=0
    for script in $shell_scripts; do
        if [ -f "$script" ] && [ ! -x "$script" ]; then
            non_exec=$((non_exec + 1))
        fi
    done
    
    if [ "$non_exec" -gt 0 ]; then
        log "INFO" "$non_exec shell scripts are not executable"
    fi
}

# Check git security
check_git_security() {
    log "SECTION" "Checking git security"
    echo "" >> "$REPORT_FILE"
    
    if [ ! -d "$PROJECT_ROOT/.git" ]; then
        log "INFO" "Not a git repository"
        return
    fi
    
    cd "$PROJECT_ROOT"
    
    # Check for .gitignore
    if [ -f ".gitignore" ]; then
        log "PASS" ".gitignore file exists"
        
        # Check if common sensitive patterns are ignored
        local should_ignore=("node_modules" ".env" "*.key" "*.pem")
        for pattern in "${should_ignore[@]}"; do
            if ! grep -q "$pattern" .gitignore 2>/dev/null; then
                log "WARN" "$pattern should be in .gitignore"
            fi
        done
    else
        log "WARN" "No .gitignore file found"
    fi
}

# Generate summary
generate_summary() {
    echo "" >> "$REPORT_FILE"
    {
        echo ""
        echo "═══════════════════════════════════════════════════════════════"
        echo "📊 SCAN SUMMARY"
        echo "═══════════════════════════════════════════════════════════════"
        echo ""
        echo "✅ Checks Passed:    $PASSED_CHECKS"
        echo "⚠️  Warnings Found:  $WARNINGS_FOUND"
        echo "❌ Vulnerabilities:  $VULNERABILITIES_FOUND"
        echo ""
        echo "═══════════════════════════════════════════════════════════════"
    } >> "$REPORT_FILE"
    
    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}📊 SCAN SUMMARY${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${GREEN}✅ Checks Passed:    $PASSED_CHECKS${NC}"
    echo -e "${YELLOW}⚠️  Warnings Found:  $WARNINGS_FOUND${NC}"
    echo -e "${RED}❌ Vulnerabilities:  $VULNERABILITIES_FOUND${NC}"
    echo ""
    echo -e "${BLUE}📄 Full report: $REPORT_FILE${NC}"
    echo ""
    
    if [ "$VULNERABILITIES_FOUND" -gt 0 ]; then
        echo -e "${RED}🚨 Security issues found - please review and fix!${NC}"
        exit 1
    elif [ "$WARNINGS_FOUND" -gt 0 ]; then
        echo -e "${YELLOW}⚠️  Warnings found - consider reviewing${NC}"
        exit 0
    else
        echo -e "${GREEN}🎉 Security scan passed!${NC}"
        exit 0
    fi
}

# Main execution
main() {
    show_header
    init_report
    
    case $SCAN_MODE in
        "full")
            check_sensitive_files
            check_hardcoded_secrets
            check_dangerous_patterns
            check_npm_vulnerabilities
            check_file_permissions
            check_git_security
            ;;
        "quick")
            check_sensitive_files
            check_hardcoded_secrets
            check_git_security
            ;;
        "deps")
            check_npm_vulnerabilities
            ;;
        "code")
            check_hardcoded_secrets
            check_dangerous_patterns
            ;;
    esac
    
    generate_summary
}

# Run
main
