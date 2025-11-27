/**
 * 🛡️ درع زايد للأمن السيبراني - Test Setup
 * Zayed Shield Cybersecurity - Jest Setup
 */

// Mock browser APIs for JSDOM environment
global.console = {
  ...console,
  log: jest.fn(),
  warn: jest.fn(),
  error: jest.fn(),
  info: jest.fn(),
};

// Mock localStorage
const localStorageMock = {
  getItem: jest.fn(),
  setItem: jest.fn(),
  removeItem: jest.fn(),
  clear: jest.fn(),
};
global.localStorage = localStorageMock;

// Mock navigator
Object.defineProperty(global.navigator, 'userAgent', {
  value: 'Mozilla/5.0 (Test Environment)',
  writable: true,
});

Object.defineProperty(global.navigator, 'language', {
  value: 'ar-AE',
  writable: true,
});

// Mock screen object
Object.defineProperty(global, 'screen', {
  value: {
    width: 1920,
    height: 1080,
    colorDepth: 24,
  },
  writable: true,
});

// Mock fetch API
global.fetch = jest.fn(() =>
  Promise.resolve({
    json: () => Promise.resolve({ ip: '127.0.0.1' }),
    ok: true,
  })
);

// Mock Intl
global.Intl = {
  DateTimeFormat: () => ({
    resolvedOptions: () => ({ timeZone: 'Asia/Dubai' }),
  }),
};

// Clean up after each test
afterEach(() => {
  jest.clearAllMocks();
});
