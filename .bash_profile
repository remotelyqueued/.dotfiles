#
# ~/.bash_profile
#

# npm
# https://wiki.archlinux.org/title/environment_variables#Per_user
# https://wiki.archlinux.org/title/Node.js_#Allow_user-wide_installations
#
PATH="$HOME/.local/bin:$PATH"
export npm_config_prefix="$HOME/.local"

# default
[[ -f ~/.bashrc ]] && . ~/.bashrc
