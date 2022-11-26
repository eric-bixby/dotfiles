# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh:BEGIN ---------------------

# Disable colorization of ls command
export DISABLE_LS_COLORS=true

# Supress warning "zsh compinit: insecure directories and files, run compaudit for list." when openning terminal
export ZSH_DISABLE_COMPFIX=true

# Path to oh-my-zsh installation.
export ZSH=~/git/ohmyzsh

# Set name of the theme to load.
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

# Activate oh-my-zsh
source $ZSH/oh-my-zsh.sh

# oh-my-zsh:END -----------------------

# Enable iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Set path for my personal scripts
export PATH=$PATH:$HOME/bin
export PATH=$PATH:~/Docs/Code/BASH
export PATH=$PATH:~/Docs/Code/BASH/MyDevApps
export PATH=$PATH:~/Docs/Code/BASH/MyMacApps

# Set default editor
export EDITOR=vi

# Enable vscode command-line
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# Functions:BEGIN ---------------------

cd_code() {
    cd_docs Code/$*
}

cd_code_bash() {
    cd_code BASH/$*
}

cd_code_py() {
    cd_code Python/$*
}

cd_docs() {
    cd ~/Docs/$*
}

cd_git() {
    cd ~/git/$*
}

cd_git_asb() {
    cd_git auto-sort-bookmarks-webext/$*
}

cd_git_site() {
    cd_git eric-bixby.github.io/$*
}

cd_icloud_docs() {
    cd "${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Documents/$*"
}

# Set custom prompt with newline
prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        print -n "%{%k%}"
    fi

    print -n "%{%f%}"
    CURRENT_BG=''

    # Adds the new line and ➜ as the start character
    printf "\n ➜";
}

# Functions:END -----------------------
# Aliases:BEGIN -----------------------

alias npm_list='npm list -g --depth=0 2>&1|grep -v "peer dep missing"'
alias mount_docs='mount_docs.sh && rehash'
alias rm='trash-put -iv'
alias site_build='cd_git_site && bundle exec jekyll build'
alias site_run='cd_git_site && bundle exec jekyll serve'
alias site_update='cd_git_site && bundle update'

# Aliases:END -------------------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

