/**
 * 🛡️ درع زايد للأمن السيبراني - Jest Configuration
 * Zayed Shield Cybersecurity - Test Configuration
 */

module.exports = {
  // Test environment
  testEnvironment: 'jsdom',

  // Test file patterns
  testMatch: [
    '**/tests/**/*.test.js',
    '**/__tests__/**/*.js',
  ],

  // Coverage configuration
  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  collectCoverageFrom: [
    'index.js',
    'src/**/*.js',
    '!**/node_modules/**',
    '!**/dist/**',
  ],

  // Coverage thresholds (relaxed for initial setup)
  coverageThreshold: {
    global: {
      branches: 0,
      functions: 0,
      lines: 0,
      statements: 0,
    },
  },

  // Module paths
  moduleFileExtensions: ['js', 'json'],

  // Transform configuration
  transform: {
    '^.+\\.js$': 'babel-jest',
  },

  // Setup files
  setupFilesAfterEnv: ['<rootDir>/tests/setup.js'],

  // Test timeout
  testTimeout: 10000,

  // Verbose output
  verbose: true,

  // Clear mocks between tests
  clearMocks: true,

  // Restore mocks between tests
  restoreMocks: true,
};
