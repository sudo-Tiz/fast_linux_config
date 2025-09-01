# 🚀 Fast Linux Config

> **Minimal dotfiles to quickly setup a new Linux environment**

Lightweight and efficient configurations for Neovim, Zsh, and Bash.

## 📦 Quick Setup

```bash
# Install essentials
sudo apt update && sudo apt upgrade -y
sudo apt install -y zsh neovim curl git

# Get configs
curl -LO https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/.zshrc
curl --create-dirs -Lo ~/.config/nvim/init.vim \
  https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/init.vim

# Switch to zsh
chsh -s $(which zsh) && zsh
```

## ✨ Features

### Neovim
- Auto-installs vim-plug and essential plugins
- NERDTree, vim-surround, commentary, airline, vimagit
- Vi mode, split navigation, auto-cleanup

### Zsh/Bash
- Colorful prompt: `[user@host path]$`
- Vi mode with adaptive cursor
- 10M history with deduplication  
- 50+ git/python/nav aliases
- Syntax highlighting

### Bash Alternative
Don't want to switch to Zsh? Use the Bash version instead:
```bash
curl -LO https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/.bashrc
```