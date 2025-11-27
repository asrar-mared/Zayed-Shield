# 🛡️ المساهمة في درع زايد | Contributing to Zayed Shield

<div dir="rtl">

## 🇦🇪 مرحباً بك في مجتمع درع زايد!

شكراً لاهتمامك بالمساهمة في مشروع درع زايد للأمن السيبراني. نحن نقدر كل مساهمة صغيرة كانت أم كبيرة.

</div>

---

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Project Structure](#project-structure)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Security Guidelines](#security-guidelines)

---

## 📜 Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md) to maintain a respectful and inclusive community.

---

## 🤝 How to Contribute

### 1. Reporting Bugs 🐛

- Check existing issues first to avoid duplicates
- Use the bug report template
- Include:
  - Clear description
  - Steps to reproduce
  - Expected vs actual behavior
  - Environment details (OS, Node version, etc.)

### 2. Suggesting Features 💡

- Open a feature request issue
- Describe the feature and its use case
- Explain how it aligns with the project's goals

### 3. Code Contributions 💻

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Write/update tests
5. Commit with clear messages
6. Push to your fork
7. Open a Pull Request

---

## 🔧 Development Setup

### Prerequisites

- Node.js >= 14.0.0
- npm >= 6.0.0
- Git

### Installation

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/Zayed-Shield.git
cd Zayed-Shield

# Install dependencies
npm install

# Run tests to verify setup
npm test

# Build the project
npm run build
```

### Available Scripts

| Script | Description |
|--------|-------------|
| `npm run build` | Build production bundle |
| `npm run dev` | Development mode with watch |
| `npm test` | Run test suite |
| `npm run lint` | Run ESLint |

---

## 📁 Project Structure

```
Zayed-Shield/
├── src/                    # Source files
│   ├── core/               # Core protection modules
│   │   └── protection.js   # Main protection class
│   ├── utils/              # Utility functions
│   │   └── security.js     # Security utilities
│   ├── modules/            # Feature modules
│   └── index.js            # Main entry point
├── tests/                  # Test files
│   ├── setup.js            # Test configuration
│   └── protection.test.js  # Test suites
├── scripts/                # Build and automation scripts
├── .github/                # GitHub configuration
│   └── workflows/          # CI/CD workflows
├── index.js                # Browser protection script
├── index.d.ts              # TypeScript definitions
├── package.json            # Package configuration
├── webpack.config.js       # Webpack configuration
├── jest.config.js          # Jest configuration
└── README.md               # Project documentation
```

---

## 📏 Coding Standards

### JavaScript

- Use ES6+ features
- Follow ESLint rules (`.eslintrc.js`)
- 4-space indentation
- Single quotes for strings
- Semicolons required
- JSDoc comments for functions

```javascript
/**
 * Example function with proper documentation
 * @param {string} param - Parameter description
 * @returns {boolean} Return value description
 */
function exampleFunction(param) {
    // Use const/let, never var
    const result = param.toLowerCase();
    
    // Always use strict equality
    if (result === 'expected') {
        return true;
    }
    
    return false;
}
```

### Shell Scripts

- Use `#!/bin/bash` shebang
- Set `set -euo pipefail` for safety
- Quote all variables
- Use meaningful variable names
- Add comments in Arabic and/or English

```bash
#!/bin/bash
# 🛡️ Script description / وصف السكربت
set -euo pipefail

# Variable declaration
readonly LOG_FILE="/var/log/shield.log"

# Function with description
log_message() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$LOG_FILE"
}
```

### Commit Messages

Follow conventional commits:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code style (formatting)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance

Example:
```
feat(protection): add screenshot detection

Added new module to detect PrintScreen key presses
and screen capture API usage.

Closes #123
```

---

## 🧪 Testing Guidelines

### Writing Tests

- Place tests in `tests/` directory
- Name files with `.test.js` suffix
- Group related tests with `describe()`
- Use clear `it()` descriptions

```javascript
describe('FeatureName', () => {
    describe('methodName', () => {
        it('should do something specific', () => {
            // Arrange
            const input = 'test';
            
            // Act
            const result = methodName(input);
            
            // Assert
            expect(result).toBe(expected);
        });
    });
});
```

### Running Tests

```bash
# Run all tests
npm test

# Run with coverage
npm test -- --coverage

# Run specific test file
npm test -- tests/protection.test.js

# Run in watch mode
npm test -- --watch
```

---

## 🔄 Pull Request Process

### Before Submitting

1. ✅ Tests pass (`npm test`)
2. ✅ Linting passes (`npm run lint`)
3. ✅ Build succeeds (`npm run build`)
4. ✅ Documentation updated if needed
5. ✅ Commit messages follow convention

### PR Checklist

- [ ] Branch is up to date with `main`
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No security vulnerabilities introduced
- [ ] Code follows style guidelines

### Review Process

1. Automated checks run
2. Maintainers review code
3. Address feedback
4. Approval and merge

---

## 🔐 Security Guidelines

### Reporting Vulnerabilities

**Do NOT report security issues publicly.**

Email: security@zayed-shield.ae

Include:
- Description of vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

### Security Best Practices

- Never commit secrets or credentials
- Use environment variables for sensitive data
- Validate and sanitize all inputs
- Follow OWASP guidelines
- Keep dependencies updated

---

## 🏆 Recognition

Contributors will be:
- Listed in CREDITS.md
- Mentioned in release notes
- Eligible for special badges

---

## 📞 Contact

- **Discord**: [Join our server](https://discord.gg/zayedshield)
- **Telegram**: [@zayedshield](https://t.me/zayedshield)
- **Email**: contributors@zayed-shield.ae

---

<div align="center">

### 🇦🇪 شكراً لمساهمتك في حماية الفضاء الرقمي العربي 🇦🇪

**Thank you for contributing to Zayed Shield!**

</div>
