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
# requires "brew install"
#plugins=(brew zsh-autosuggestions zsh-syntax-highlighting)
plugins=(aliases git python web-search)

# Activate oh-my-zsh
source $ZSH/oh-my-zsh.sh

# oh-my-zsh:END -----------------------

# Enable iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Set path for my personal scripts
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/git/home-scripts/BASH
export PATH=$PATH:~/git/home-scripts/Python

# Set path for local node tools
export PATH=$PATH:./node_modules/.bin

# Enable vscode command-line
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# Set default editor
export EDITOR=vi

# Hide homwbrew hints
export HOMEBREW_NO_ENV_HINTS=true

# Functions:BEGIN ---------------------

cd_code() {
    cd_git home-scripts/$*
}

cd_code_bash() {
    cd_code BASH/$*
}

cd_code_java() {
    cd_code Java/$*
}

cd_code_py() {
    cd_code Python/$*
}

cd_docs() {
    cd ~/Docs/$*
}

cd_dl() {
    cd_code_java DownloadLinks/$*
}

cd_git() {
    cd ~/git/$*
}

cd_git_asb() {
    cd_git auto-sort-bookmarks-webext/$*
}

cd_git_bm() {
    cd_git bookmarks/$*
}

cd_git_dot() {
    cd_git dotfiles/$*
}

cd_git_notes() {
    cd_git notes/$*
}

cd_git_site() {
    cd_git eric-bixby.github.io/$*
}

cd_icloud() {
    cd "${HOME}/Library/Mobile Documents/$*"
}

cd_icloud_docs() {
    cd_icloud "com~apple~CloudDocs/Documents/$*"
}

cd_icloud_obsidian() {
    cd_icloud "iCloud~md~obsidian/Documents/$*"
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
alias bm='pushd $PWD;cd_git_bm && ./update.sh;popd'
alias brew_leaves='brew leaves | xargs brew deps --formula --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"|grep -v six'
alias c='clear'
alias cdc='cd ~ && c'
alias dl='pushd $PWD;cd_dl && ./run.sh;popd'
alias docker_rm_stopped='docker ps --filter status=exited -q|xargs docker rm'
alias gl_pull='git_local.sh pull'
alias gl_status='git_local.sh status -s'
alias h='history -i'
alias matrix='cmatrix'
alias npm_leaves='npm list -g --depth=0 2>&1|grep -v "peer dep missing"'
alias pip_leaves='pipdeptree|grep "=="|grep -v "pip="|grep -v setuptools|grep -v six|grep -v wheel'
alias rl='cd_git_notes && get_reading_list.py|sort -o ReadingList-`date "+%Y%m%d-%H%M%S"`.md'
alias ssh_nas='ssh root@nas-ba-f3-f8.local'
alias ssh_pi='ssh pi@raspberrypi.local'
# Aliases:END -------------------------

# Enable nvm (Python)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Enable venv (Python)
# py -m venv .venv
source ~/.venv/bin/activate

# Enable JDK on MacOS
[ -e /Library/Java ] && export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home

# Enable zsh for Docker Desktop
#source "${HOME}/.docker/init-zsh.sh" || true

# Enable p10k prompt for zsh; to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

