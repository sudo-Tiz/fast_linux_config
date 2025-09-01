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
        da='deactivate'\

ch() { curl "http://cheat.sh/$@"; }

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
