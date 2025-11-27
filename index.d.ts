/**
 * 🛡️ درع زايد للأمن السيبراني - TypeScript Definitions
 * Zayed Shield Cybersecurity - Type Definitions
 * 
 * @description Complete TypeScript type definitions for Zayed CyberShield protection system
 * @version 1.0.0
 * @license MIT
 * @author Zayed CyberShield Team
 * @copyright 2024 UAE Digital Protection Initiative
 */

/**
 * Configuration options for protection features
 */
export interface ProtectionOptions {
  /** Enable right-click prevention */
  preventRightClick?: boolean;
  /** Enable text selection prevention */
  preventTextSelection?: boolean;
  /** Enable keyboard shortcuts blocking */
  preventKeyboardShortcuts?: boolean;
  /** Enable developer tools detection */
  preventDevTools?: boolean;
  /** Enable source viewing prevention */
  preventSourceViewing?: boolean;
  /** Enable screen capture detection */
  detectScreenCapture?: boolean;
  /** Enable watermark protection */
  watermarkProtection?: boolean;
  /** Enable session monitoring */
  sessionMonitoring?: boolean;
  /** Enable geolocation tracking */
  geolocationTracking?: boolean;
  /** Enable behavior analysis */
  behaviorAnalysis?: boolean;
}

/**
 * Watermark configuration options
 */
export interface WatermarkOptions {
  /** Watermark text content */
  text?: string;
  /** Font size in rem units */
  fontSize?: string;
  /** Text color with opacity */
  color?: string;
  /** Rotation angle in degrees */
  rotation?: number;
  /** Z-index for positioning */
  zIndex?: number;
}

/**
 * Security violation record
 */
export interface SecurityViolation {
  /** ISO timestamp of the violation */
  timestamp: string;
  /** Human-readable description */
  description: string;
  /** Violation type code */
  type: ViolationType;
  /** Browser user agent */
  userAgent: string;
  /** Client IP address (if available) */
  ip?: string;
  /** Current page URL */
  url: string;
  /** Referrer URL */
  referrer: string;
  /** Screen dimensions */
  screenSize: string;
  /** Browser language */
  language: string;
}

/**
 * Violation type codes
 */
export type ViolationType =
  | 'RIGHT_CLICK'
  | 'TEXT_SELECTION'
  | 'KEYBOARD_SHORTCUT'
  | 'DEV_TOOLS'
  | 'CONSOLE_ACCESS'
  | 'SOURCE_ACCESS'
  | 'SCREEN_CAPTURE'
  | 'SCREENSHOT'
  | 'WATERMARK_REMOVAL'
  | 'INACTIVE_SESSION'
  | 'GEOLOCATION'
  | 'GEOLOCATION_DENIED'
  | 'SUSPICIOUS_BEHAVIOR';

/**
 * Security report structure
 */
export interface SecurityReport {
  /** Project information */
  projectInfo: ProjectInfo;
  /** Session duration in milliseconds */
  sessionDuration: number;
  /** Total number of violations */
  totalViolations: number;
  /** List of security violations */
  violations: SecurityViolation[];
  /** Report generation timestamp */
  timestamp: string;
}

/**
 * Project information
 */
export interface ProjectInfo {
  /** Project name (encoded) */
  name: string;
  /** Project owner */
  owner: string;
  /** Protection status */
  protection: boolean;
  /** Initialization timestamp */
  timestamp: number;
}

/**
 * Configuration options for ZayedCyberShield
 */
export interface ZayedCyberShieldOptions {
  /** Enable all protection features */
  enableProtection?: boolean;
  /** Watermark text */
  watermarkText?: string;
  /** Interface language */
  language?: 'ar' | 'en' | 'ar-AE' | 'ar-SA';
  /** Protection mode */
  mode?: 'standard' | 'enhanced' | 'maximum';
  /** Custom protection options */
  protection?: ProtectionOptions;
  /** Custom watermark options */
  watermark?: WatermarkOptions;
  /** Enable logging */
  logging?: boolean;
  /** Custom violation handler */
  onViolation?: (violation: SecurityViolation) => void;
  /** Custom critical breach handler */
  onCriticalBreach?: () => void;
}

/**
 * 🛡️ ZayedCyberShield Protection Class
 * 
 * Main class for implementing cybersecurity protection features.
 * Provides comprehensive protection against various web-based threats.
 * 
 * @example
 * ```typescript
 * import ZayedCyberShield from '@zayed-cybershield/protection';
 * 
 * const shield = new ZayedCyberShield({
 *   enableProtection: true,
 *   language: 'ar',
 *   mode: 'maximum'
 * });
 * 
 * // Check protection status
 * console.log(shield.isProtected()); // true
 * 
 * // Get security report
 * const report = shield.getSecurityReport();
 * ```
 */
declare class ZayedCyberShield {
  /**
   * Creates a new ZayedCyberShield instance
   * @param options - Configuration options
   */
  constructor(options?: ZayedCyberShieldOptions);

  /**
   * Initialize all protection features
   */
  initProtection(): void;

  /**
   * Check if protection is currently active
   * @returns Protection status
   */
  isProtected(): boolean;

  /**
   * Generate a security report
   * @returns Current security report
   */
  getSecurityReport(): SecurityReport;

  /**
   * Log a security violation
   * @param description - Violation description
   * @param type - Violation type
   */
  logViolation(description: string, type: ViolationType): void;

  /**
   * Show a security warning dialog
   * @param title - Warning title
   * @param message - Warning message
   */
  showWarning(title: string, message: string): void;

  /**
   * Trigger critical security breach response
   */
  criticalSecurityBreach(): void;

  /**
   * Get all logged violations
   * @returns Array of security violations
   */
  getViolations(): SecurityViolation[];

  /**
   * Clear all logged violations
   */
  clearViolations(): void;

  /**
   * Update protection options
   * @param options - New options to apply
   */
  updateOptions(options: Partial<ZayedCyberShieldOptions>): void;

  /**
   * Disable all protection features
   */
  disable(): void;

  /**
   * Re-enable protection features
   */
  enable(): void;
}

/**
 * Global window interface extension
 */
declare global {
  interface Window {
    /** ZayedCyberShield global instance */
    ZayedCyberShield: {
      /** Get current security report */
      getSecurityReport: () => SecurityReport;
      /** Check if protection is active */
      isProtected: () => boolean;
    };
  }
}

export default ZayedCyberShield;
export { ZayedCyberShield };
