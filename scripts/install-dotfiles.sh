#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Installing dotfiles from $DOTFILES_DIR"

# Backup existing files and create symlinks
backup_and_link() {
    local src="$1"
    local dest="$2"

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        echo "  Backing up $dest to $dest.backup"
        mv "$dest" "$dest.backup"
    fi

    if [[ -L "$dest" ]]; then
        rm "$dest"
    fi

    echo "  Linking $src -> $dest"
    ln -s "$src" "$dest"
}

# Zsh
backup_and_link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
[[ -f "$DOTFILES_DIR/zsh/.p10k.zsh" ]] && backup_and_link "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# Git (optional - uncomment if you want to symlink gitconfig)
# backup_and_link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

echo ""
echo "==> Dotfiles installed!"
echo "    Run 'source ~/.zshrc' or restart your terminal"
