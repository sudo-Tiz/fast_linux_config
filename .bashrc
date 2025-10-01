# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable colors and change prompt:
PS1='\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\w\[\e[1;31m\]]\[\e[0m\]$ '
stty stop undef # Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=10000000
HISTFILESIZE=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/bash/history"
# Create cache directory if it doesn't exist
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/bash"

# History options (bash equivalents)
HISTCONTROL=ignoreboth:erasedups # Don't record duplicate entries and entries starting with space
shopt -s histappend              # Append to history file, don't overwrite
shopt -s histverify              # Show command before executing from history

# Enable auto cd (bash 4.0+)
shopt -s autocd 2>/dev/null

# Basic auto/tab complete:
# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Include hidden files in completion
bind 'set match-hidden-files on'
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'

# vi mode
set -o vi
export KEYTIMEOUT=1

# Bash vi mode cursor shapes and key bindings
bind 'set keymap vi-insert'
bind '"\e[3~": delete-char'
bind '"\C-r": reverse-search-history'

# Edit line in vim with ctrl-e:
bind '"\C-e": edit-and-execute-command'

# Cursor shape for vi modes (bash doesn't have native support, using workaround)
function set_cursor_beam() { echo -ne '\e[5 q'; }
function set_cursor_block() { echo -ne '\e[1 q'; }

# Set beam cursor on startup
set_cursor_beam

# Hook for prompt to reset cursor
PROMPT_COMMAND="set_cursor_beam; $PROMPT_COMMAND"

# Aliases
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
  v="nvim" \
  g="git" \
  gd="git diff" \
  gcl='git clone' \
  gull='git pull' \
  gush='git push' \
  gco='git commit -m' \
  ga='git add' \
  gr='git restore' \
  grs='git restore --staged' \
  greset1='git reset --hard HEAD~1' \
  gusho='git push -f origin' \
  gst='git status' \
  gl='git log' \
  gb='git branch' \
  gch="git checkout" \
  gchb="git checkout -b" \
  gls='l --group-directories-first --color=auto -d $(git ls-tree $(git branch | grep \* | cut -d " " -f2) --name-only)' \
  gll='l --group-directories-first --color=auto -d $(git ls-tree -r $(git branch | grep \* | cut -d " " -f2) --name-only)' \
  ve='python -m venv .env' \
  va='source ./.env/bin/activate || source ./env/bin/activate || source ./.venv/bin/activate' \
  veva='python -m venv .env && source ./.env/bin/activate' \
  da='deactivate' \
  sagi='sudo apt get install' \
  sagu='sudo apt get update && sudo apt get upgrade' \
  sp='sudo pacman' \
  p='pacman'

ch() { curl "http://cheat.sh/$1"; }

# Load bash syntax highlighting if available
if [ -f /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh ]; then
  source /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh 2>/dev/null
fi
