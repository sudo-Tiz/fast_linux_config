# 🚀 Fast Linux Config

> **Minimal dotfiles to quickly setup a new Linux environment**

Lightweight and efficient configurations for Neovim, Tmux, Zsh, and Bash.

## 📦 Quick Setup

```bash
# Install essentials
sudo apt update && sudo apt upgrade -y
sudo apt install -y zsh neovim curl git tmux

# Nvim 
curl --create-dirs -Lo ~/.config/nvim/init.vim \
  https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/init.vim

# Tmux
curl --create-dirs -Lo ~/.config/tmux/tmux.conf \
  https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/tmux.conf

# Bash
curl -LO https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/.bashrc

# Zsh
curl -LO https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/.zshrc && \
    chsh -s zsh && zsh
```
