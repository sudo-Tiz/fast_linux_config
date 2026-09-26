# 🚀 Fast Linux Config

> **Minimal dotfiles to quickly setup a new Linux environment**

Lightweight and efficient configurations for Neovim, Tmux, Zsh, and Bash.

## 📦 Quick Setup

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y zsh neovim curl git tmux
```

### Vim + Bash

```bash
curl -Lo ~/.vimrc  https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/.vimrc
curl -Lo ~/.bashrc https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/.bashrc
```

### Neovim + Zsh

```bash
curl --create-dirs -Lo ~/.config/nvim/init.lua \
  https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/init.lua
curl -Lo ~/.zshrc https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/.zshrc
chsh -s zsh && zsh
```

Nvim plugins optional: install `init.plugins.lua` instead of `init.lua` — lazy.nvim bootstraps NvChad/LSP/completion on first launch.

### Tmux

```bash
curl --create-dirs -Lo ~/.config/tmux/tmux.conf \
  https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/tmux.conf
```

TPM plugins off by default: set a `@enable_*` flag to `1` in `tmux.conf`, `prefix + r`, then `prefix + I` to install.

