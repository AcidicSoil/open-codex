#!/bin/bash

# Codex CLI Setup Script
# This script sets up the Open Codex CLI for development and usage

set -e  # Exit on any error

echo "🚀 Setting up Open Codex CLI..."

# Check Node.js version
NODE_VERSION=$(node --version | cut -d'v' -f2)
REQUIRED_VERSION="22.0.0"

if [[ "$(printf '%s\n' "$REQUIRED_VERSION" "$NODE_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]]; then
    echo "❌ Node.js version $NODE_VERSION found, but version 22+ is required"
    echo "Please update Node.js to version 22 or higher"
    exit 1
fi

echo "✅ Node.js version $NODE_VERSION is compatible"

# Create configuration directory
echo "📁 Creating configuration directory..."
mkdir -p ~/.codex

# Check if config.json exists
if [[ ! -f ~/.codex/config.json ]]; then
    echo "⚙️ Creating default configuration..."
    cat > ~/.codex/config.json << 'EOF'
{
  "model": "o4-mini",
  "provider": "openai",
  "approvalMode": "suggest",
  "fullAutoErrorMode": "ask-user"
}
EOF
    echo "✅ Created ~/.codex/config.json"
else
    echo "✅ Configuration file already exists"
fi

# Check if instructions.md exists
if [[ ! -f ~/.codex/instructions.md ]]; then
    echo "📝 Creating default instructions..."
    cat > ~/.codex/instructions.md << 'EOF'
# Global Codex Instructions

These instructions apply to all your Codex sessions.

## General Guidelines
- Always explain your reasoning before making changes
- Use clear, descriptive commit messages
- Follow existing code style and patterns
- Add comments for complex logic

## Preferences
- Use meaningful variable names
- Prefer explicit over implicit code
- Add error handling where appropriate
- Write tests for new functionality

## Custom Instructions
Add your personal preferences here:
- Programming language preferences
- Code style preferences
- Framework/library preferences
- Security considerations
EOF
    echo "✅ Created ~/.codex/instructions.md"
else
    echo "✅ Instructions file already exists"
fi

# Build and link the CLI
echo "🔨 Building and linking the CLI..."
cd codex-cli
npm install
npm run build
npm link

echo "✅ CLI built and linked successfully"

# Test the CLI
echo "🧪 Testing CLI installation..."
if command -v open-codex &> /dev/null; then
    echo "✅ CLI command 'open-codex' is available"
else
    echo "❌ CLI command not found. Please check your PATH"
    exit 1
fi

# Create .env template if it doesn't exist
cd ..
if [[ ! -f .env.template ]]; then
    echo "📄 Creating .env template..."
    cat > .env.template << 'EOF'
# Codex CLI Environment Variables Template
# Copy this file to .env and uncomment/fill in your API keys

# OpenAI API Key (default provider)
# OPENAI_API_KEY=your-openai-api-key-here

# Google Gemini API Key (for Gemini provider)
# GOOGLE_GENERATIVE_AI_API_KEY=your-gemini-api-key-here

# OpenRouter API Key (for OpenRouter provider)
# OPENROUTER_API_KEY=your-openrouter-api-key-here

# xAI API Key (for xAI provider)
# XAI_API_KEY=your-xai-api-key-here

# Ollama doesn't require an API key (runs locally)

# Optional: Set debug mode
# DEBUG=true

# Optional: Set quiet mode for CI/CD
# CODEX_QUIET_MODE=1

# Optional: Disable project docs
# CODEX_DISABLE_PROJECT_DOC=1
EOF
    echo "✅ Created .env.template"
fi

# Add environment variables to shell profile if not already present
SHELL_RC=""
if [[ -f ~/.bashrc ]]; then
    SHELL_RC="~/.bashrc"
elif [[ -f ~/.zshrc ]]; then
    SHELL_RC="~/.zshrc"
fi

if [[ -n "$SHELL_RC" ]]; then
    if ! grep -q "# Codex CLI Environment Variables" "$SHELL_RC" 2>/dev/null; then
        echo "🔧 Adding environment variable placeholders to $SHELL_RC..."
        echo "" >> "$SHELL_RC"
        echo "# Codex CLI Environment Variables" >> "$SHELL_RC"
        echo "# export OPENAI_API_KEY=\"your-api-key-here\"  # Uncomment and add your API key" >> "$SHELL_RC"
        echo "# export GOOGLE_GENERATIVE_AI_API_KEY=\"your-gemini-api-key-here\"  # For Gemini provider" >> "$SHELL_RC"
        echo "✅ Added environment variable placeholders to $SHELL_RC"
    fi
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Add your API key(s) to ~/.codex/config.json or create a .env file"
echo "2. Customize ~/.codex/instructions.md with your preferences"
echo "3. Run 'open-codex --help' to see available options"
echo "4. Start using Codex with 'open-codex \"your prompt here\"'"
echo ""
echo "For more information, see the README.md file."