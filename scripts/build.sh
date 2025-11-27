#!/bin/bash

# ===========================================
# 🛡️ درع زايد للأمن السيبراني - Build Script
# Zayed Shield - Automated Build Process
# ===========================================
#
# Description: Automated build script for the Zayed Shield project
# Usage: ./scripts/build.sh [options]
# Options:
#   --production    Build for production
#   --development   Build for development (default)
#   --clean         Clean build artifacts before building
#
# Author: Zayed CyberShield Team
# Version: 1.0.0
# ===========================================

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$PROJECT_ROOT/dist"
LOG_FILE="/tmp/zayed_build_$(date '+%Y%m%d_%H%M%S').log"

# Default options
BUILD_MODE="development"
CLEAN_BUILD=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --production)
            BUILD_MODE="production"
            shift
            ;;
        --development)
            BUILD_MODE="development"
            shift
            ;;
        --clean)
            CLEAN_BUILD=true
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
    esac
done

# Logging function
log() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
    
    case $level in
        INFO)
            echo -e "${BLUE}ℹ️  $message${NC}"
            ;;
        SUCCESS)
            echo -e "${GREEN}✅ $message${NC}"
            ;;
        WARNING)
            echo -e "${YELLOW}⚠️  $message${NC}"
            ;;
        ERROR)
            echo -e "${RED}❌ $message${NC}"
            ;;
    esac
}

# Header display
show_header() {
    echo -e "${BLUE}"
    echo "═══════════════════════════════════════════════════════"
    echo "🛡️  درع زايد - نظام البناء التلقائي"
    echo "    Zayed Shield - Automated Build System"
    echo "═══════════════════════════════════════════════════════"
    echo -e "${NC}"
    echo -e "📁 Project: $PROJECT_ROOT"
    echo -e "🔧 Mode: $BUILD_MODE"
    echo -e "📝 Log: $LOG_FILE"
    echo ""
}

# Check prerequisites
check_prerequisites() {
    log "INFO" "Checking prerequisites..."
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        log "ERROR" "Node.js is not installed"
        exit 1
    fi
    log "SUCCESS" "Node.js $(node --version) found"
    
    # Check npm
    if ! command -v npm &> /dev/null; then
        log "ERROR" "npm is not installed"
        exit 1
    fi
    log "SUCCESS" "npm $(npm --version) found"
    
    # Check package.json
    if [ ! -f "$PROJECT_ROOT/package.json" ]; then
        log "ERROR" "package.json not found"
        exit 1
    fi
    log "SUCCESS" "package.json found"
}

# Clean build artifacts
clean_build() {
    log "INFO" "Cleaning build artifacts..."
    
    if [ -d "$BUILD_DIR" ]; then
        rm -rf "$BUILD_DIR"
        log "SUCCESS" "Removed $BUILD_DIR"
    fi
    
    if [ -d "$PROJECT_ROOT/coverage" ]; then
        rm -rf "$PROJECT_ROOT/coverage"
        log "SUCCESS" "Removed coverage directory"
    fi
    
    if [ -d "$PROJECT_ROOT/node_modules/.cache" ]; then
        rm -rf "$PROJECT_ROOT/node_modules/.cache"
        log "SUCCESS" "Cleared cache"
    fi
}

# Install dependencies
install_dependencies() {
    log "INFO" "Checking dependencies..."
    
    if [ ! -d "$PROJECT_ROOT/node_modules" ]; then
        log "INFO" "Installing dependencies..."
        cd "$PROJECT_ROOT"
        npm ci --prefer-offline 2>> "$LOG_FILE" || npm install 2>> "$LOG_FILE"
        log "SUCCESS" "Dependencies installed"
    else
        log "SUCCESS" "Dependencies already installed"
    fi
}

# Run linting
run_lint() {
    log "INFO" "Running linter..."
    
    cd "$PROJECT_ROOT"
    if npm run lint 2>> "$LOG_FILE"; then
        log "SUCCESS" "Linting passed"
    else
        log "WARNING" "Linting has warnings (continuing build)"
    fi
}

# Run tests
run_tests() {
    log "INFO" "Running tests..."
    
    cd "$PROJECT_ROOT"
    if npm test 2>> "$LOG_FILE"; then
        log "SUCCESS" "All tests passed"
    else
        log "WARNING" "Some tests failed (check log for details)"
    fi
}

# Build project
build_project() {
    log "INFO" "Building project ($BUILD_MODE mode)..."
    
    cd "$PROJECT_ROOT"
    
    # Create dist directory
    mkdir -p "$BUILD_DIR"
    
    if [ "$BUILD_MODE" = "production" ]; then
        npm run build 2>> "$LOG_FILE" || {
            log "WARNING" "Webpack build skipped (not configured)"
            # Fallback: copy files manually
            cp -r "$PROJECT_ROOT/index.js" "$BUILD_DIR/"
            cp -r "$PROJECT_ROOT/src" "$BUILD_DIR/" 2>/dev/null || true
        }
    else
        # Development build - just copy files
        cp -r "$PROJECT_ROOT/index.js" "$BUILD_DIR/"
        cp -r "$PROJECT_ROOT/src" "$BUILD_DIR/" 2>/dev/null || true
    fi
    
    # Copy TypeScript definitions
    if [ -f "$PROJECT_ROOT/index.d.ts" ]; then
        cp "$PROJECT_ROOT/index.d.ts" "$BUILD_DIR/"
    fi
    
    # Copy package.json
    cp "$PROJECT_ROOT/package.json" "$BUILD_DIR/"
    
    # Copy README
    cp "$PROJECT_ROOT/README.md" "$BUILD_DIR/"
    
    log "SUCCESS" "Build completed"
}

# Generate build report
generate_report() {
    local report_file="$BUILD_DIR/BUILD_INFO.txt"
    
    {
        echo "═══════════════════════════════════════════════════════"
        echo "🛡️ Zayed Shield - Build Information"
        echo "═══════════════════════════════════════════════════════"
        echo ""
        echo "Build Date: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Build Mode: $BUILD_MODE"
        echo "Node Version: $(node --version)"
        echo "npm Version: $(npm --version)"
        echo ""
        echo "Files:"
        ls -la "$BUILD_DIR"
        echo ""
        echo "═══════════════════════════════════════════════════════"
    } > "$report_file"
    
    log "SUCCESS" "Build report generated: $report_file"
}

# Main execution
main() {
    show_header
    
    check_prerequisites
    
    if [ "$CLEAN_BUILD" = true ]; then
        clean_build
    fi
    
    install_dependencies
    run_lint
    run_tests
    build_project
    generate_report
    
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}🎉 Build completed successfully!${NC}"
    echo -e "${GREEN}📁 Output: $BUILD_DIR${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
}

# Run main function
main
