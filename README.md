# fast_linux_config
#### just a few dotfiles to start working on a new linux environment

<br /> 

## Here are the first command i run on a new debian/ubuntu environment

### Update & install basic prog
apt update && apt upgrade -y && apt install -y zsh neovim curl

### Import basic zsh config 
cd
curl -LO https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/.zshrc
zsh

### Import basic neovim config
curl --create-dirs -Lo ~/.config/nvim/init.nvim https://raw.githubusercontent.com/sudo-Tiz/fast_linux_config/main/init.vim

