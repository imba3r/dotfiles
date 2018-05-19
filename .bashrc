# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set bell-style visible

# set the prompt function
export PROMPT_COMMAND="set_bash_prompt"

# PS1 (prompt) colors
DF="\e[0m"    # default
CU="\e[1;32m" # bold teal
CG="\e[1;31m" # bold red
CH="\e[1;35m" # bold purple
CP="\e[1;34m" # bold blue

# prepare bash prompt git support
GIT_PROMPT_SH="/usr/share/git/completion/git-prompt.sh"
if [[ -x /usr/bin/git && -f $GIT_PROMPT_SH ]]; then
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWUPSTREAM=1
    source $GIT_PROMPT_SH
    GIT='$(__git_ps1 "─['$CG'%s'$DF']")'
fi

# assemble the PS1
function set_bash_prompt {
    local ec="$?"
    [[ "$ec" != "0" ]] && ec="[$CG${ec}$DF]─" || ec=""
    PS1='┌─'$ec'['$CU'\u'$DF'@'$CH'\h'$DF']─['$CP'\W'$DF']'$GIT'\n└─╼ '
}

# colorize Manpages
export LESS_TERMCAP_mb=$'\E[01;31m' \
export LESS_TERMCAP_md=$'\E[01;38;5;74m' \
export LESS_TERMCAP_me=$'\E[0m' \
export LESS_TERMCAP_se=$'\E[0m' \
export LESS_TERMCAP_so=$'\E[38;5;246m' \
export LESS_TERMCAP_ue=$'\E[0m' \
export LESS_TERMCAP_us=$'\E[04;38;5;146m' \

# XDG default dirs
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# setup environment
export EDITOR="vim"
export FCEDIT="vim"
export PAGER="/usr/bin/less -R"
export SYSTEMD_PAGER="/usr/bin/less -R"
export LESSHISTFILE=-

# dev stuff
export GOPATH="$HOME/Projects/go"
export PATH=$PATH:"$GOPATH/bin"
export YARNPATH=$HOME/.yarn
export PATH=$PATH:"$YARNPATH/bin"

# keepass
export KP_DATABASE_PATH="${HOME}/.passwords.kdbx"
export KP_PASSWORD_FILE="${HOME}/.passwords.kdbx.credentials"
KP_DATABASE_SOURCE="${HOME}/Dropbox/Important/Keepass/passwords.kdbx"
if [ -f "${KP_DATABASE_SOURCE}" ]; then
    ln -sf "$KP_DATABASE_SOURCE" "$KP_DATABASE_PATH"
fi

# improve appearance
export GDK_USE_XFT=1
export QT_XFT=true
export QT_QPA_PLATFORMTHEME=qt5ct
export _JAVA_AWT_WM_NONREPARENTING=1

# Colorize `grep` and `ls`
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto --group-directories-first'

# ls aliases
alias ll="ls -lh"
alias la="ls -lah"
alias lt="ls -ltr"
alias lr="ls -lR"

# systemd aliases
alias suspend='systemctl suspend'
alias shutdown='systemctl poweroff'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'

# archlinux maintenance
alias pacnew='find / -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null'
alias modified-config-files='pacman -Q | pacman -Qii | awk '\''{if ($1 == "MODIFIED") print $2}'\'''
alias pacaur='pacaur --noconfirm --noedit'
function remove-orphans {
    sudo pacman -Rns $(pacman -Qqdt)
}

# other aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias more='less'
alias less='less -r'
alias cp='cp -ir'
alias df='df -h'
alias free='free -h'
alias du='du -s -h'
alias top='htop --sort-key=PERCENT_CPU'
alias pgg='ping www.google.de'
