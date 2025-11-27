/**
 * 🛡️ درع زايد للأمن السيبراني - Core Protection Module
 * Zayed Shield Cybersecurity - Core Protection Engine
 * 
 * @module src/core/protection
 * @description Core protection functionality for the Zayed CyberShield system
 * @version 1.0.0
 * @license MIT
 * @author Zayed CyberShield Team
 * 
 * This module provides the fundamental protection mechanisms including:
 * - Right-click prevention
 * - Text selection blocking
 * - Keyboard shortcut interception
 * - Developer tools detection
 */

'use strict';

/**
 * Project information (encoded for security)
 * @type {Object}
 * @private
 */
const PROJECT_INFO = {
    name: 'درع زايد للأمن السيبراني',
    owner: 'دولة الإمارات العربية المتحدة',
    protection: true,
    timestamp: Date.now(),
};

/**
 * Dangerous keyboard combinations to block
 * @type {Array<Object>}
 * @private
 */
const DANGEROUS_COMBOS = [
    // Developer tools
    { ctrl: true, key: 'F12' },
    { ctrl: true, shift: true, key: 'I' },
    { ctrl: true, shift: true, key: 'J' },
    { ctrl: true, shift: true, key: 'C' },
    { key: 'F12' },
    
    // Copy/paste/save
    { ctrl: true, key: 'A' },
    { ctrl: true, key: 'C' },
    { ctrl: true, key: 'V' },
    { ctrl: true, key: 'X' },
    { ctrl: true, key: 'S' },
    { ctrl: true, key: 'P' },
    
    // View source
    { ctrl: true, key: 'U' },
    
    // Refresh
    { key: 'F5' },
    { ctrl: true, key: 'R' },
    
    // Fullscreen
    { key: 'F11' },
];

/**
 * CoreProtection Class
 * Provides fundamental protection mechanisms for web applications.
 * 
 * @class
 * @example
 * const protection = new CoreProtection({
 *     enableRightClick: true,
 *     enableKeyboard: true
 * });
 * protection.init();
 */
class CoreProtection {
    /**
     * Creates a new CoreProtection instance
     * @param {Object} options - Configuration options
     * @param {boolean} [options.enableRightClick=true] - Enable right-click prevention
     * @param {boolean} [options.enableTextSelection=true] - Enable text selection prevention
     * @param {boolean} [options.enableKeyboard=true] - Enable keyboard shortcut blocking
     * @param {boolean} [options.enableDevTools=true] - Enable DevTools detection
     * @param {Function} [options.onViolation] - Callback for violations
     */
    constructor(options = {}) {
        this.options = {
            enableRightClick: true,
            enableTextSelection: true,
            enableKeyboard: true,
            enableDevTools: true,
            onViolation: null,
            ...options,
        };
        
        this.violations = [];
        this.isInitialized = false;
    }

    /**
     * Initialize protection mechanisms
     * @returns {void}
     */
    init() {
        if (this.isInitialized) {
            return;
        }

        if (typeof document === 'undefined') {
            console.warn('CoreProtection: No document available');
            return;
        }

        if (this.options.enableRightClick) {
            this._preventRightClick();
        }

        if (this.options.enableTextSelection) {
            this._preventTextSelection();
        }

        if (this.options.enableKeyboard) {
            this._preventKeyboardShortcuts();
        }

        if (this.options.enableDevTools) {
            this._preventDevTools();
        }

        this.isInitialized = true;
        console.log('🛡️ CoreProtection initialized');
    }

    /**
     * Prevent right-click context menu
     * @private
     */
    _preventRightClick() {
        document.addEventListener('contextmenu', (e) => {
            e.preventDefault();
            this._logViolation('محاولة النقر بالزر الأيمن', 'RIGHT_CLICK');
            return false;
        });
    }

    /**
     * Prevent text selection
     * @private
     */
    _preventTextSelection() {
        document.addEventListener('selectstart', (e) => {
            e.preventDefault();
            this._logViolation('محاولة تحديد النص', 'TEXT_SELECTION');
            return false;
        });

        document.addEventListener('dragstart', (e) => {
            e.preventDefault();
            return false;
        });

        // Add CSS protection
        const style = document.createElement('style');
        style.textContent = `
            * {
                -webkit-user-select: none !important;
                -moz-user-select: none !important;
                -ms-user-select: none !important;
                user-select: none !important;
            }
            ::selection { background: transparent !important; }
        `;
        document.head.appendChild(style);
    }

    /**
     * Prevent dangerous keyboard shortcuts
     * @private
     */
    _preventKeyboardShortcuts() {
        document.addEventListener('keydown', (e) => {
            const currentCombo = {
                ctrl: e.ctrlKey,
                shift: e.shiftKey,
                alt: e.altKey,
                key: e.key,
            };

            if (DANGEROUS_COMBOS.some((combo) => this._matchesCombo(currentCombo, combo))) {
                e.preventDefault();
                this._logViolation(`محاولة استخدام اختصار محظور: ${e.key}`, 'KEYBOARD_SHORTCUT');
                return false;
            }
        });
    }

    /**
     * Check if current key combination matches a dangerous combo
     * @param {Object} current - Current key state
     * @param {Object} target - Target combo to match
     * @returns {boolean}
     * @private
     */
    _matchesCombo(current, target) {
        return (
            (!target.ctrl || current.ctrl) &&
            (!target.shift || current.shift) &&
            (!target.alt || current.alt) &&
            current.key === target.key
        );
    }

    /**
     * Detect and prevent DevTools usage
     * @private
     */
    _preventDevTools() {
        let devToolsOpen = false;

        setInterval(() => {
            const widthThreshold = window.outerWidth - window.innerWidth > 160;
            const heightThreshold = window.outerHeight - window.innerHeight > 160;

            if ((widthThreshold || heightThreshold) && !devToolsOpen) {
                devToolsOpen = true;
                this._logViolation('محاولة فتح أدوات المطورين', 'DEV_TOOLS');
            } else if (!widthThreshold && !heightThreshold) {
                devToolsOpen = false;
            }
        }, 500);
    }

    /**
     * Log a security violation
     * @param {string} description - Violation description
     * @param {string} type - Violation type code
     * @private
     */
    _logViolation(description, type) {
        const violation = {
            timestamp: new Date().toISOString(),
            description,
            type,
            userAgent: typeof navigator !== 'undefined' ? navigator.userAgent : 'Unknown',
            url: typeof window !== 'undefined' ? window.location.href : 'Unknown',
        };

        this.violations.push(violation);

        if (typeof this.options.onViolation === 'function') {
            this.options.onViolation(violation);
        }

        console.warn('🚨 Security Violation:', violation);
    }

    /**
     * Get all logged violations
     * @returns {Array<Object>}
     */
    getViolations() {
        return [...this.violations];
    }

    /**
     * Get project information
     * @returns {Object}
     */
    getProjectInfo() {
        return { ...PROJECT_INFO };
    }

    /**
     * Clear violation history
     */
    clearViolations() {
        this.violations = [];
    }
}

// Export for different module systems
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { CoreProtection, DANGEROUS_COMBOS, PROJECT_INFO };
}

if (typeof window !== 'undefined') {
    window.CoreProtection = CoreProtection;
}
