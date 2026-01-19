# dotfiles

Personal dotfiles and setup scripts for macOS.

## Quick Start

### Fresh macOS Setup

```bash
# Clone this repo
git clone https://github.com/jjatinggoyal/dotfiles.git ~/personal/dotfiles

# Run the setup script
cd ~/personal/dotfiles
./scripts/macos-setup.sh

# Install dotfiles (symlinks)
./scripts/install-dotfiles.sh
```

### Just Install Dotfiles

If you already have the tools installed and just want the config files:

```bash
./scripts/install-dotfiles.sh
```

## What's Included

### macOS Setup Script (`scripts/macos-setup.sh`)

Installs:
- **Homebrew** - Package manager
- **Ghostty** - Fast, native terminal emulator
- **Oh My Zsh** - Zsh framework
- **Powerlevel10k** - Zsh theme
- **Zsh Plugins** - autosuggestions, syntax-highlighting, completions
- **Python 3.13** - With uv package manager
- **Node.js LTS** - Via nvm
- **OrbStack** - Docker Desktop alternative (faster, lighter)
- **Meslo Nerd Font** - For terminal icons

### Dotfiles

```
zsh/
  .zshrc      - Zsh configuration
  .p10k.zsh   - Powerlevel10k theme config

git/
  .gitconfig  - Git configuration
```

## Structure

```
dotfiles/
├── README.md
├── scripts/
│   ├── macos-setup.sh       # Fresh macOS setup
│   └── install-dotfiles.sh  # Symlink dotfiles
├── zsh/
│   ├── .zshrc
│   └── .p10k.zsh
└── git/
    └── .gitconfig
```

## Customization

- Edit `zsh/.zshrc` for shell customizations
- Run `p10k configure` to reconfigure Powerlevel10k theme
- Add more dotfiles to respective directories
