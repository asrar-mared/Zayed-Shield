/**
 * 🛡️ درع زايد للأمن السيبراني - Module Entry Point
 * Zayed Shield Cybersecurity - Source Index
 * 
 * @module src
 * @description Main entry point for Zayed CyberShield source modules
 * @version 1.0.0
 * @license MIT
 * @author Zayed CyberShield Team
 */

'use strict';

// Import core modules
const { CoreProtection, DANGEROUS_COMBOS, PROJECT_INFO } = require('./core/protection');
const { SecurityUtils, SUSPICIOUS_PORTS, ATTACK_PATTERNS } = require('./utils/security');

/**
 * Zayed CyberShield Module
 * @namespace ZayedShield
 */
const ZayedShield = {
    // Core protection class
    CoreProtection,

    // Security utilities
    SecurityUtils,

    // Constants
    constants: {
        DANGEROUS_COMBOS,
        SUSPICIOUS_PORTS,
        ATTACK_PATTERNS,
        PROJECT_INFO,
    },

    // Version information
    version: '1.0.0',
    
    // Project name
    name: 'درع زايد للأمن السيبراني',

    /**
     * Quick initialization method
     * @param {Object} options - Configuration options
     * @returns {CoreProtection} Initialized protection instance
     */
    init(options = {}) {
        const protection = new CoreProtection(options);
        protection.init();
        return protection;
    },

    /**
     * Get library information
     * @returns {Object} Library info
     */
    getInfo() {
        return {
            name: this.name,
            version: this.version,
            license: 'MIT',
            author: 'Zayed CyberShield Team',
            country: 'United Arab Emirates 🇦🇪',
        };
    },
};

// Export for CommonJS
if (typeof module !== 'undefined' && module.exports) {
    module.exports = ZayedShield;
}

// Export for ES Modules (if supported)
if (typeof exports !== 'undefined') {
    exports.default = ZayedShield;
    exports.CoreProtection = CoreProtection;
    exports.SecurityUtils = SecurityUtils;
}

// Global export for browser
if (typeof window !== 'undefined') {
    window.ZayedShield = ZayedShield;
}
