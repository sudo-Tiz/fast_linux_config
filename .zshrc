# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks
setopt HIST_VERIFY          # Show command before executing from history
setopt SHARE_HISTORY        # Share history between sessions

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

bindkey '^[[P' delete-char
bindkey '^R' history-incremental-search-backward

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# ################# #
# Aliases & Function
# ################# #

# COLOR & SHORTEN
alias \
    cp="cp -a" \
    mv="mv -i" \
    rm="rm -rf" \
    bc="bc -ql" \
    mkd="mkdir -pv" \
    mdtemp="cd $(mktemp -d)" \
    grep="grep --color=auto" \
    diff="diff --color=auto" \
    ip="ip -color=auto" \
    ls="ls -hN --color=auto --group-directories-first" \
    l="ls" \
    ll="ls -l" \
    la="ls -aF" \
    lla="ls -laF" \
    ...="cd ../.." \
    ....="cd ../../.." \
    .....="cd ../../../.." \
    sagi='sudo apt get install' \
    sagu='sudo apt get update && sudo apt get upgrade'\
    sp='sudo pacman'\
    p='pacman' \
    sysup='sudo systemctl enable --now' \
    sysdn='sudo systemctl disable --now' \

# Use neovim for vim if present.
[ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d" v="nvim"

# DOCKER
[ -x "$(command -v docker)" ] && alias \
  doc='sudo /bin/docker' \
  doco='sudo /bin/docker compose' \
  rmdoc='sudo /bin/docker rm -f $(/bin/docker ps -a -q)'

# GIT
[ -x "$(command -v git)" ] && alias \
  g="git" \
  gd="git diff" \
  gcl='git clone' \
  gull='git pull' \
  gush='git push' \
  gusho='git push -f origin' \
  gash="git stash" \
  gme= "git merge" \
  gmest="git merge stash" \
  gco='git commit -m' \
  gcoa='git commit -amend --no-edit' \
  ga='git add' \
  gr='git restore' \
  grs='git restore --staged' \
  greset1='git reset --hard HEAD~1' \
  gst='git status' \
  gl='git log' \
  gb='git branch' \
  gch="git checkout" \
  gchb="git checkout -b" \
  gls='l --group-directories-first --color=auto -d $(git ls-tree $(git branch | grep \* | cut -d " " -f2) --name-only)' \
  gll='l --group-directories-first --color=auto -d $(git ls-tree -r $(git branch | grep \* | cut -d " " -f2) --name-only)' \
  grao='git remote rm origin; git remote add origin'  &&
  gdi() { git diff --name-only --relative --diff-filter=d | xargs bat --diff; }

# VENV
alias \
  ve='python -m venv .venv' \
  va='source .venv/bin/activate || source .env/bin/activate' \
  veva='python -m venv .venv && source .venv/bin/activate' \
  da='deactivate'
#
# Copy progress bar
[ -x "$(command -v rsync)" ] && alias \
  cpv='rsync -ah --info=progress2' \
  mvv='rsync -ah --remove-source-files --info=progress2'

# list path to other zsh shell opened
lssh() {
  ps au |
    awk '$11 == "/usr/bin/zsh" || $11 == "/bin/zsh" { print $2 }' |
    xargs pwdx |
    awk '{ print $2 }' |
    sed -n "\|^${2}.*|p" |
    sort -u |
    nl
}
# cd to path of another shell, using fzf as selector
cs() {
  if command -v fzf &>/dev/null; then
    cmd1=$(lssh | fzf --select-1 --query "$1" --height=~50 | cut -f 2)
  else
    echo "Select a shell to change directory to:"
    lssh
    read selection
    cmd1=$(lssh | awk -v sel="$selection" 'NR == sel { print $2 }')
  fi
  cmd="cd $cmd1"
  print -S $cmd
  eval $cmd
}


ch() { curl "http://cheat.sh/$1"; }
# Backup functions
old() { mv "$1" "$1.old"; }
bak() { cp "$1" "$1.bak"; }
baktar() { tar -zcvf "${1}_$(date '+%Y-%m-%d_%H-%M').tar.gz" "$1"; }

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
