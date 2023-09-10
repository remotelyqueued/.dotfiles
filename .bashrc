####
# arch - persistent usb
# https://gitlab.archlinux.org/pacman/pacman
#
# todo:
# audit framework
##

# npm user config .bash_profile

# qemu kvm libvirt
# https://wiki.archlinux.org/title/libvirt#Client

# If not running interactively, don't do anything further
[[ $- != *i* ]] && return

# shell options
shopt -s histappend

# https://wiki.archlinux.org/title/bash#Line_wrap_on_window_resize
shopt -s checkwinsize

# https://wiki.archlinux.org/title/bash#History_customization
HISTCONTROL="erasedups:ignorespace"

# history time
HISTTIMEFORMAT="%m/%d/%y %I:%M:%S%p "

# number of lines stored during session
HISTSIZE=

# number of lines stored in file after session
HISTFILESIZE=

# colorize less
# https://wiki.archlinux.org/title/Color_output_in_console#less
export LESS='-R --use-color -Dd+r$Du+b'

# colorize man
# https://github.com/sharkdp/bat#man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# interactive search
# https://wiki.archlinux.org/title/fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# new terminals adopt current working directory
# https://wiki.archlinux.org/title/GNOME/Tips_and_tricks
source /etc/profile.d/vte.sh

# prompt colors
RESET=$(tput sgr0)
BLUE=$(tput setaf 4)
GREY=$(tput setaf 244)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)

# git prompt
git_prompt() {
  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')
  if [ -n "$BRANCH" ]; then
    echo -n "$YELLOW$BRANCH"
  if [ -n "$(git status --short)" ]; then
    echo "${RED} ✗ "
  fi
fi
}

# main prompt
PS1='\[$BLUE\w$(git_prompt)\]
\[$GREY\]$ \[$RESET\]'

# color
alias ls='ls --color=auto'
alias ip='ip --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'

# shortcuts
alias l='ls --group-directories-first -la'
alias la='ls -A'
alias ll='ls -alF'
alias lt='lsd -liFSh'
alias mount='mount | column -t'
alias duffy='sudo du -sch .[!.]* * | sort -rh'

# extend sudo timeout
# https://wiki.archlinux.org/title/Sudo#Passing_aliases
alias sudo='sudo -v; sudo '

# netctl
# https://wiki.archlinux.org/title/netctl#Obfuscate_wireless_passphrase
alias wifi='sudo wifi-menu -o'

# wpa version - man wpa_cli
alias wpa='sudo wpa_cli status'

# reflector
# https://wiki.archlinux.org/title/reflector
alias reflect="sudo reflector --verbose --protocol https \
  --latest 6  --sort rate --country 'United States' \
  --save /etc/pacman.d/mirrorlist"

# npm static server
# https://www.npmjs.com/package/http-server
alias serve="http-server -p 5500 --cors -c-1 --log-ip -r"

# terminal ui
# https://wiki.archlinux.org/title/pacman/Tips_and_tricks#Browsing_packages
alias sc="pacman -Qq | fzf --preview 'pacman -Qil {}' \
  --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias pacs='pacman --color always -Sl | sed -e "s: :/:; /installed/d" \
  | cut -f 1 -d " " | fzf --multi --ansi --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'
alias pacr="pacman --color always -Q | cut -f 1 -d ' ' | fzf --multi --ansi \
  --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

# user modifications
# https://wiki.archlinux.org/title/pacman/Tips_and_tricks#Listing_changed_backup_files
alias changed="sudo pacman -Qii | awk '/^MODIFIED/ {print $2}' | sort"

# systemd journal
# https://wiki.archlinux.org/title/Systemd/Journal#Journal_access_as_user
alias failed='systemctl --failed'
# alias journal='journalctl -p 3 -xb'
alias journal='journalctl -f | bat --paging=never -l log'

# security
# https://wiki.archlinux.org/title/security#Hardware_vulnerabilities
alias vuln='grep -r . /sys/devices/system/cpu/vulnerabilities/'

# apparmor
# https://wiki.archlinux.org/title/AppArmor#Installation
alias lsm='cat /sys/kernel/security/lsm'

# bare git repo
# https://wiki.archlinux.org/title/Dotfiles
alias config='/usr/bin/git --git-dir=/home/ryan/.dotfiles/ --work-tree=/home/ryan'
source /usr/share/bash-completion/completions/git
__git_complete config __git_main
