/**
 * 🛡️ درع زايد للأمن السيبراني - ESLint Configuration
 * Zayed Shield Cybersecurity - Linting Rules
 * 
 * @description ESLint configuration for maintaining code quality
 * @version 1.0.0
 */

module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true,
    jest: true,
  },
  extends: [
    'eslint:recommended',
  ],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  rules: {
    // Code quality
    'no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
    'no-console': 'off', // Allow console for security logging
    'no-debugger': 'error',
    
    // Best practices
    'eqeqeq': ['error', 'always'],
    'curly': ['error', 'all'],
    'no-eval': 'error',
    'no-implied-eval': 'error',
    'no-new-func': 'error',
    
    // Security
    'no-script-url': 'error',
    
    // Style
    'indent': ['error', 4, { SwitchCase: 1 }],
    'quotes': ['error', 'single', { avoidEscape: true }],
    'semi': ['error', 'always'],
    'comma-dangle': ['error', 'always-multiline'],
    
    // ES6
    'prefer-const': 'error',
    'no-var': 'error',
    'arrow-spacing': 'error',
  },
  ignorePatterns: [
    'node_modules/',
    'dist/',
    'coverage/',
    '*.min.js',
  ],
};
