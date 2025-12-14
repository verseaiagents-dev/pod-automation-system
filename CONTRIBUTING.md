# Contributing to POD Automation System

Thank you for your interest in contributing to the POD Automation System! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Reporting Issues](#reporting-issues)

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow. Please be respectful and constructive in all interactions.

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Set up your development environment
4. Create a new branch for your feature or fix

## Development Setup

### Prerequisites

- n8n (v1.x or higher)
- Node.js (v18+)
- Airtable account
- Slack workspace (for testing)
- API keys for Claude, NanoBanana/DALL-E

### Local Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/pod-automation-system.git
cd pod-automation-system

# Copy environment file
cp .env.example .env

# Configure your API keys in .env
```

### n8n Development

For local n8n development:

```bash
# Using Docker
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n
```

## How to Contribute

### Types of Contributions

- **Bug Fixes**: Fix issues and improve stability
- **Features**: Add new tools or capabilities
- **Documentation**: Improve docs, add examples
- **Workflows**: Contribute n8n workflow templates
- **Tests**: Add or improve testing

### Branch Naming

Use descriptive branch names:

- `feature/add-new-tool` - New features
- `fix/printify-rate-limit` - Bug fixes
- `docs/improve-readme` - Documentation
- `refactor/optimize-workflow` - Code improvements

## Pull Request Process

1. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Your Changes**
   - Follow the style guidelines
   - Add tests if applicable
   - Update documentation

3. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "feat: add new design style option"
   ```

4. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Open a Pull Request**
   - Use a clear, descriptive title
   - Reference any related issues
   - Describe your changes in detail

### Commit Message Format

Follow conventional commits:

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

Examples:
```
feat: add support for hoodie mockups
fix: handle Printify rate limit errors
docs: update API reference for new tools
```

## Style Guidelines

### n8n Workflows

- Use clear, descriptive node names
- Add comments for complex logic
- Group related nodes visually
- Include error handling nodes
- Test workflows before submitting

### JSON/Configuration Files

- Use 2-space indentation
- Include descriptions for all fields
- Follow existing naming conventions

### Documentation

- Use clear, concise language
- Include code examples where helpful
- Keep README sections updated
- Add screenshots for visual features

## Reporting Issues

### Bug Reports

Include:
- Clear description of the issue
- Steps to reproduce
- Expected vs actual behavior
- n8n version
- Relevant logs or screenshots

### Feature Requests

Include:
- Clear description of the feature
- Use case / problem it solves
- Possible implementation approach
- Any relevant examples

## Questions?

If you have questions about contributing, feel free to:
- Open a discussion on GitHub
- Check existing issues and discussions

Thank you for contributing!
