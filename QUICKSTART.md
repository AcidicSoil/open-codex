# Quick Start Guide

Get Open Codex CLI running in under 5 minutes!

## Prerequisites

- **Node.js 22+** - Check with `node --version`
- **Git** (recommended for version control)
- An API key from your preferred provider

## Option 1: Quick Setup (Recommended)

```bash
# Run the automated setup script
./setup.sh
```

This script will:
- ✅ Verify Node.js version
- ✅ Build and link the CLI globally
- ✅ Create configuration files
- ✅ Set up environment variables
- ✅ Test the installation

## Option 2: Manual Setup

```bash
# Install dependencies and build
cd codex-cli
npm install
npm run build
npm link

# Create config directory
mkdir -p ~/.codex

# Create basic config (optional)
echo '{"provider": "openai", "model": "o4-mini"}' > ~/.codex/config.json
```

## Step 2: Add Your API Key

Choose one method:

### Method A: Environment Variable (Persistent)
```bash
# Add to your shell profile (~/.bashrc or ~/.zshrc)
export OPENAI_API_KEY="your-api-key-here"

# Reload your shell
source ~/.bashrc  # or ~/.zshrc
```

### Method B: .env File (Project-specific)
```bash
# Copy the template and edit
cp .env.template .env
# Then edit .env and uncomment/fill in your API key
```

## Step 3: Test It

```bash
# Test the CLI is working
open-codex --help

# Try a simple command
open-codex "explain what this project does"

# Or run in full auto mode (careful!)
open-codex --approval-mode full-auto "create a simple hello world script"
```

## API Key Setup by Provider

| Provider | Environment Variable | Get API Key |
|----------|---------------------|-------------|
| OpenAI | `OPENAI_API_KEY` | [platform.openai.com](https://platform.openai.com/api-keys) |
| Gemini | `GOOGLE_GENERATIVE_AI_API_KEY` | [aistudio.google.com](https://aistudio.google.com/app/apikey) |
| OpenRouter | `OPENROUTER_API_KEY` | [openrouter.ai](https://openrouter.ai/keys) |
| xAI | `XAI_API_KEY` | [x.ai](https://x.ai/) |
| Ollama | None (local) | [Install Ollama](https://ollama.ai/) |

## Common Issues

**Command not found**: Make sure npm's global bin directory is in your PATH
```bash
npm config get prefix
# Add {prefix}/bin to your PATH
```

**Permission errors**: Don't use `sudo` with npm. Fix npm permissions instead:
```bash
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH
```

**Node version error**: Update Node.js to version 22+
```bash
# Using nvm (recommended)
nvm install 22
nvm use 22
```

## Next Steps

- Read the full [README.md](./README.md) for detailed documentation
- Customize `~/.codex/instructions.md` with your preferences
- Try the examples in the [recipes section](./README.md#recipes)
- Explore different approval modes: `suggest`, `auto-edit`, `full-auto`

## Help & Support

- Run `open-codex --help` for command options
- Check the [FAQ section](./README.md#faq) in the README
- Open an issue on GitHub for bugs or feature requests

Happy coding! 🚀