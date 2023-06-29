###
# arch
##

# shell options
shopt -s histappend

# https://wiki.archlinux.org/title/bash#Common_programs_and_options
# https://wiki.archlinux.org/title/bash#Invocation
# [[ $- != *i* ]] && return

# https://wiki.archlinux.org/title/bash#Line_wrap_on_window_resize
shopt -s checkwinsize

# https://wiki.archlinux.org/title/bash#Shorter_history
HISTCONTROL=erasedups

# time
HISTTIMEFORMAT='%D %I:%M %p '

# number of lines stored during session
HISTSIZE=

# number of lines stored in file after session
HISTFILESIZE=

# wireshark decrypt
# export SSLKEYLOGFILE=/home/ryan/.mozilla/ssl-key.log

# privoxy
# https://wiki.archlinux.org/title/privoxy
# http_proxy="http://localhost:8118"

# colorize less
# https://wiki.archlinux.org/title/Color_output_in_console#less
export LESS='-R --use-color -Dd+r$Du+b'

# colorize man
# https://github.com/sharkdp/bat#man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# default editor
export EDITOR=nvim
export VISUAL=nvim

# npm user config
# https://wiki.archlinux.org/title/environment_variables#Per_user
# https://wiki.archlinux.org/title/Node.js_#Allow_user-wide_installations
#
# located in .bash_profile
# PATH="$HOME/.local/bin:$PATH"
# export npm_config_prefix="$HOME/.local"

# interactive search
# https://wiki.archlinux.org/title/fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# gnome terminal - open new tab in same directory
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
alias grep='grep -n --color=auto --exclude-dir=data_sets'

# shortcuts
alias l='ls --group-directories-first -la'
alias la='ls -A'
alias ll='ls -alF'
alias lt='lsd -liFSh'
alias mount='mount | column -t'
alias duffy='sudo du -sch .[!.]* * | sort -rh'

# entropy
# https://wiki.archlinux.org/title/Random_number_generation#/dev/random
alias ent='cat /proc/sys/kernel/random/entropy_avail'
alias pool='cat /proc/sys/kernel/random/pools'

# netctl
# https://wiki.archlinux.org/title/netctl#Obfuscate_wireless_passphrase
alias wifi='sudo wifi-menu -o'

# extend sudo timeout
# https://wiki.archlinux.org/title/Sudo#Passing_aliases
alias sudo='sudo -v; sudo '

# reflector
# https://wiki.archlinux.org/title/reflector
alias reflect="sudo reflector --verbose --protocol https \
  --latest 6  --sort rate --country 'United States' \
  --save /etc/pacman.d/mirrorlist"

# npm static server
# https://www.npmjs.com/package/http-server
alias serve="http-server -p 5500 --cors -c-1 --log-ip -r"

# package visualizer
# https://wiki.archlinux.org/title/pacman/Tips_and_tricks#Browsing_packages
alias sc="pacman -Qq | fzf --preview 'pacman -Qil {}' \
  --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

# modified configuration
# https://wiki.archlinux.org/title/pacman/Tips_and_tricks#Listing_changed_backup_files
alias changed="sudo pacman -Qii | awk '/^MODIFIED/ {print $2}' | sort"

# todo
# https://wiki.archlinux.org/title/firejail
# alias subl='firejail subl'

# systemd journal
# +adm / +wheel group
# https://wiki.archlinux.org/title/Systemd/Journal#Journal_access_as_user
alias failed='systemctl --failed'
alias journal='journalctl -p 3 -xb'

# qemu kvm libvirt
# https://wiki.archlinux.org/title/libvirt#Client
#
# alias vm-start='sudo systemctl start libvirtd.service &&
#   sudo virsh net-start default &&
#   sudo virsh net-list --all'
# 
# alias vm-stop='sudo virsh net-destroy default &&
#   sudo systemctl stop libvirtd.service &&
#   sudo systemctl stop libvirtd-admin.socket &&
#   sudo systemctl stop libvirtd-ro.socket &&
#   sudo systemctl stop libvirtd.socket'

# razer
# https://wiki.archlinux.org/title/Razer_Blade
# alias razer-start='systemctl --user start openrazer-daemon.service'
# alias razer-stop='systemctl --user stop openrazer-daemon.service'

# security
# https://wiki.archlinux.org/title/security#Hardware_vulnerabilities
alias vuln='grep -r . /sys/devices/system/cpu/vulnerabilities/'

# bare git repo
# https://wiki.archlinux.org/title/Dotfiles
alias config='/usr/bin/git --git-dir=/home/ryan/.dotfiles/ --work-tree=/home/ryan'
source /usr/share/bash-completion/completions/git
__git_complete config __git_main
