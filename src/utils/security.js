/**
 * 🛡️ درع زايد للأمن السيبراني - Security Utilities
 * Zayed Shield Cybersecurity - Security Utility Functions
 * 
 * @module src/utils/security
 * @description Security utility functions for validation, hashing, and threat detection
 * @version 1.0.0
 * @license MIT
 * @author Zayed CyberShield Team
 */

'use strict';

/**
 * Suspicious port numbers commonly used by malware
 * @type {Array<number>}
 */
const SUSPICIOUS_PORTS = [
    1337,   // Leet/Elite
    31337,  // Back Orifice
    4444,   // Metasploit default
    5555,   // Android ADB
    6666,   // IRC
    7777,   // ICQP
    8888,   // Alternative HTTP
    9999,   // IANA assigned
    12345,  // NetBus
    27374,  // SubSeven
];

/**
 * Attack tool process names to detect
 * @type {Array<string>}
 */
const ATTACK_PATTERNS = [
    'nc',
    'netcat',
    'nmap',
    'hydra',
    'metasploit',
    'msfconsole',
    'nikto',
    'sqlmap',
    'aircrack',
    'hashcat',
    'john',
    'wireshark',
    'tcpdump',
];

/**
 * SecurityUtils - Security utility functions
 * @namespace
 */
const SecurityUtils = {
    /**
     * Validate an IP address format
     * @param {string} ip - IP address to validate
     * @returns {boolean} True if valid IPv4 address
     * @example
     * SecurityUtils.isValidIP('192.168.1.1') // true
     * SecurityUtils.isValidIP('invalid') // false
     */
    isValidIP(ip) {
        if (!ip || typeof ip !== 'string') {
            return false;
        }
        
        const ipRegex = /^(\d{1,3}\.){3}\d{1,3}$/;
        if (!ipRegex.test(ip)) {
            return false;
        }

        const parts = ip.split('.');
        return parts.every((part) => {
            const num = parseInt(part, 10);
            return num >= 0 && num <= 255;
        });
    },

    /**
     * Check if a port number is suspicious
     * @param {number} port - Port number to check
     * @returns {boolean} True if port is suspicious
     * @example
     * SecurityUtils.isSuspiciousPort(1337) // true
     * SecurityUtils.isSuspiciousPort(80) // false
     */
    isSuspiciousPort(port) {
        const portNum = parseInt(port, 10);
        return SUSPICIOUS_PORTS.includes(portNum);
    },

    /**
     * Check if a process name matches known attack tools
     * @param {string} processName - Process name or command
     * @returns {boolean} True if matches attack pattern
     * @example
     * SecurityUtils.isAttackTool('nmap -sS') // true
     * SecurityUtils.isAttackTool('node server.js') // false
     */
    isAttackTool(processName) {
        if (!processName || typeof processName !== 'string') {
            return false;
        }
        
        const lowerName = processName.toLowerCase();
        return ATTACK_PATTERNS.some((pattern) => lowerName.includes(pattern));
    },

    /**
     * Generate a simple hash of a string
     * 
     * WARNING: This is NOT cryptographically secure. It is intended for:
     * - Generating unique identifiers for logging purposes
     * - Creating quick checksums for comparison
     * - Non-security-critical fingerprinting
     * 
     * For security-sensitive operations (password storage, data integrity, etc.),
     * use Node.js crypto module: require('crypto').createHash('sha256')
     * 
     * @param {string} str - String to hash
     * @returns {string} Hash string (not cryptographically secure)
     * @example
     * SecurityUtils.simpleHash('test') // '364492'
     */
    simpleHash(str) {
        if (!str || typeof str !== 'string') {
            return '0';
        }

        let hash = 0;
        for (let i = 0; i < str.length; i++) {
            const char = str.charCodeAt(i);
            hash = ((hash << 5) - hash) + char;
            hash = hash & hash; // Convert to 32-bit integer
        }
        return Math.abs(hash).toString();
    },

    /**
     * Generate a unique session ID
     * @returns {string} Unique session ID
     * @example
     * SecurityUtils.generateSessionId() // 'zs-1638360000000-abc123'
     */
    generateSessionId() {
        const timestamp = Date.now();
        const random = Math.random().toString(36).substring(2, 8);
        return `zs-${timestamp}-${random}`;
    },

    /**
     * Sanitize user input to prevent XSS
     * @param {string} input - User input to sanitize
     * @returns {string} Sanitized string
     * @example
     * SecurityUtils.sanitizeInput('<script>alert("xss")</script>')
     * // '&lt;script&gt;alert("xss")&lt;/script&gt;'
     */
    sanitizeInput(input) {
        if (!input || typeof input !== 'string') {
            return '';
        }

        const map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#x27;',
            '/': '&#x2F;',
        };

        return input.replace(/[&<>"'/]/g, (char) => map[char]);
    },

    /**
     * Validate a configuration object
     * @param {Object} config - Configuration to validate
     * @param {Array<string>} requiredFields - Required field names
     * @returns {boolean} True if valid
     * @example
     * SecurityUtils.validateConfig({a: 1, b: 2}, ['a', 'b']) // true
     */
    validateConfig(config, requiredFields) {
        if (!config || typeof config !== 'object') {
            return false;
        }

        return requiredFields.every((field) => field in config);
    },

    /**
     * Create a violation record object
     * @param {string} description - Violation description
     * @param {string} type - Violation type code
     * @returns {Object} Violation record
     */
    createViolation(description, type) {
        return {
            timestamp: new Date().toISOString(),
            description,
            type,
            userAgent: typeof navigator !== 'undefined' ? navigator.userAgent : 'Unknown',
            url: typeof window !== 'undefined' ? window.location.href : 'Unknown',
            referrer: typeof document !== 'undefined' ? document.referrer : '',
            screenSize: typeof screen !== 'undefined' ? `${screen.width}x${screen.height}` : 'Unknown',
            language: typeof navigator !== 'undefined' ? navigator.language : 'Unknown',
        };
    },

    /**
     * Get the current timestamp in UAE timezone
     * @returns {string} Formatted timestamp
     */
    getUAETimestamp() {
        const options = {
            timeZone: 'Asia/Dubai',
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
        };

        try {
            return new Date().toLocaleString('ar-AE', options);
        } catch {
            return new Date().toISOString();
        }
    },

    /**
     * Check if the current environment is a browser
     * @returns {boolean} True if in browser environment
     */
    isBrowser() {
        return typeof window !== 'undefined' && typeof document !== 'undefined';
    },

    /**
     * Check if the current environment is Node.js
     * @returns {boolean} True if in Node.js environment
     */
    isNode() {
        return typeof process !== 'undefined' && 
               process.versions && 
               process.versions.node;
    },
};

// Export for different module systems
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        SecurityUtils,
        SUSPICIOUS_PORTS,
        ATTACK_PATTERNS,
    };
}

if (typeof window !== 'undefined') {
    window.SecurityUtils = SecurityUtils;
}
