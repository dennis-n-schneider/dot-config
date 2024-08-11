# By default, set rwx------ rights for newly created files
# RedHat-Linux uses the same default
umask 0077

# Use vim keys in tab complete menu:
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char
#bindkey -M menuselect 'j' vi-down-line-or-history

# Enable tab completion
autoload -Uz compinit
# Enable tab completion for Hydra (python-package)
autoload bashcompinit && bashcompinit
# Enable tab completion for pydoit
fpath=($XDG_DATA_HOME/zsh/tabcompletion $fpath)

# XDG-compliance
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
HISTFILE=$XDG_CACHE_HOME/shell/histfile


####################################################################################
# PLUGINS
####################################################################################

# Custom source-on-enter/exit plugin
autoload -U add-zsh-hook
load-enter-script() { 
    if [[ -f ~-/.exit && -r ~-/.exit ]]; then
        source ~-/.exit
    fi
    if [[ -f .enter && -r .enter ]]; then
        source .enter
    fi
}
add-zsh-hook chpwd load-enter-script

# fzf-integration in completion-selection menu
[ ! -f $XDG_DATA_HOME/fzf-tab/fzf-tab.plugin.zsh ] || source $XDG_DATA_HOME/fzf-tab/fzf-tab.plugin.zsh

# Autosuggestions (fish-like)
[ ! -f $XDG_DATA_HOME/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ] || source $XDG_DATA_HOME/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

####################################################################################


# History-size
HISTSIZE=1000000
SAVEHIST=1000000
# Size of directory stack for pushd/popd-functionality
DIRSTACKSIZE=8
# Append per session when using multiple sessions in parallel
setopt appendhistory
# Ignore duplicates in history
setopt histignorealldups
setopt extendedglob
# Turn off beep-sound on errors
unsetopt beep

# Zsh-specific aliasrc
source $ZDOTDIR/aliasrc.zsh
source $ZDOTDIR/inputrc.zsh
# Colortheme
eval "$(starship init zsh)"
# zoxide
eval "$(zoxide init zsh)"
# pyenv
eval "$(pyenv init -)"

source <(fzf --zsh)

function set_win_title() {
    echo -ne "\033]0; Alacritty: $(basename "$PWD") \007"
}
precmd_functions+=(set_win_title)
