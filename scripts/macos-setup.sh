#!/bin/bash
set -e

echo "==> macOS Development Setup Script"
echo "==> Tested on macOS Tahoe"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() { echo -e "${GREEN}==>${NC} $1"; }
print_warning() { echo -e "${YELLOW}Warning:${NC} $1"; }
print_error() { echo -e "${RED}Error:${NC} $1"; }

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    print_error "This script is for macOS only"
    exit 1
fi

# =============================================================================
# Xcode Command Line Tools
# =============================================================================
print_status "Checking Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
    print_status "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Press any key after Xcode CLI tools installation is complete..."
    read -n 1
else
    echo "  Already installed"
fi

# =============================================================================
# Homebrew
# =============================================================================
print_status "Checking Homebrew..."
if ! command -v brew &>/dev/null; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "  Already installed"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# =============================================================================
# Terminal & Shell
# =============================================================================
print_status "Installing Ghostty terminal..."
brew install --cask ghostty || echo "  Already installed"

print_status "Installing Oh My Zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "  Already installed"
fi

print_status "Installing Powerlevel10k theme..."
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ ! -d "$P10K_DIR" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
    echo "  Already installed"
fi

print_status "Installing zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# zsh-autosuggestions
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "  zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "  zsh-syntax-highlighting already installed"
fi

# zsh-completions
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]]; then
    git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
else
    echo "  zsh-completions already installed"
fi

# =============================================================================
# Programming Languages
# =============================================================================
print_status "Installing Python 3.13 and uv..."
brew install python@3.13 uv || echo "  Already installed"

print_status "Installing nvm (Node Version Manager)..."
brew install nvm || echo "  Already installed"

# Create nvm directory
mkdir -p "$HOME/.nvm"

# Load nvm for this session
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

print_status "Installing Node.js LTS..."
nvm install --lts || echo "  Already installed"

# =============================================================================
# Containers
# =============================================================================
print_status "Installing OrbStack (Docker alternative)..."
brew install --cask orbstack || echo "  Already installed"

# =============================================================================
# Fonts
# =============================================================================
print_status "Installing Nerd Fonts for terminal..."
brew install --cask font-meslo-lg-nerd-font || echo "  Already installed"

# =============================================================================
# Summary
# =============================================================================
echo ""
echo "=========================================="
print_status "Setup complete!"
echo "=========================================="
echo ""
echo "Installed:"
echo "  - Homebrew (package manager)"
echo "  - Ghostty (terminal)"
echo "  - Oh My Zsh + Powerlevel10k theme"
echo "  - Zsh plugins: git, autosuggestions, syntax-highlighting, completions"
echo "  - Python 3.13 + uv"
echo "  - Node.js LTS (via nvm)"
echo "  - OrbStack (Docker alternative)"
echo "  - Meslo Nerd Font"
echo ""
echo "Next steps:"
echo "  1. Copy dotfiles: cp zsh/.zshrc ~/.zshrc"
echo "  2. Open Ghostty - Powerlevel10k will prompt for configuration"
echo "  3. Open OrbStack to complete its setup"
echo "  4. Configure git: git config --global user.name 'Your Name'"
echo "                    git config --global user.email 'your@email.com'"
echo ""
