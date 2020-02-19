# Path to your oh-my-zsh installation.
export ZSH=/home/alistair/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="gallois"
ZSH_THEME="alistair"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)
plugins=(python git mercurial)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# # android sdk path
# export ANDROID_HOME="/opt/android-sdk-linux"
# export PATH="$PATH:/opt/android-sdk-linux/tools"
# export PATH="$PATH:/opt/android-sdk-linux/platform-tools"
# export PATH="$PATH:/opt/android-sdk-linux/build"

# # jdk
# export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
# export PATH="$PATH:/usr/lib/jvm/java-7-openjdk-amd64/bin"

# virtualenv
source /usr/bin/virtualenvwrapper.sh

# django debug flag
export DJ_DEBUG="True"

alias apt-up="sudo apt-get update -qq && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt autoremove -y"
alias g="git"

# ELASTICHOSTS ALIASES

# SSH aliases
alias ewww='ssh elastic-www@alistair.elastichosts.com'
alias eapi='ssh elastic-api@alistair.elastichosts.com'
alias eftp='ssh elastic-ftp@alistair.elastichosts.com'

PATH="$PATH:/home/alistair/repos/arcanist/bin/"

ESYNC_TARGET=alistair.elastichosts.com
ESYNC_REPO=code
esync:update_cluster() {
  echo "SYNCING DATA  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
  rsync -rltpogDvzH --delete -e ssh ~alistair/repos/eh/$ESYNC_REPO/ elastic-www@$ESYNC_TARGET:hg/
  rsync -rltpogDvzH --delete -e ssh ~/repos/eh/$ESYNC_REPO/ elastic-api@$ESYNC_TARGET:hg/
  rsync -rltpogDvzH --delete -e ssh ~/repos/eh/$ESYNC_REPO/ elastic-ftp@$ESYNC_TARGET:hg/
  echo "SYNCED DATA  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
}
esync:restart_services() {
  echo "RESTARTING THE WEB SERVER  :::::::::::::::::::::::::::::::::::::::::::"
  ssh elastic-www@$ESYNC_TARGET '/bin/bash -l -c "/home/elastic-www/.shutdownrc"'
  ssh elastic-www@$ESYNC_TARGET '/bin/bash -l -c "/home/elastic-www/.startuprc"'
  echo "WEB SERVER RESTARTED  ::::::::::::::::::::::::::::::::::::::::::::::::"
  echo "RESTARTING THE API SERVER  :::::::::::::::::::::::::::::::::::::::::::"
  ssh elastic-api@$ESYNC_TARGET '/bin/bash -l -c "/home/elastic-api/.shutdownrc"'
  ssh elastic-api@$ESYNC_TARGET '/bin/bash -l -c "/home/elastic-api/.startuprc"'
  echo "API SERVER RESTARTED  ::::::::::::::::::::::::::::::::::::::::::::::::"
  echo "RESTARTING THE FTP SERVER  :::::::::::::::::::::::::::::::::::::::::::"
  ssh elastic-ftp@$ESYNC_TARGET '/bin/bash -l -c "/home/elastic-ftp/.shutdownrc"'
  ssh elastic-ftp@$ESYNC_TARGET '/bin/bash -l -c "/home/elastic-ftp/.startuprc"'
  echo "FTP SERVER RESTARTED  ::::::::::::::::::::::::::::::::::::::::::::::::"
}
esync:rebuild_assets() {
  echo "REBUILDING ASSETS"
  ssh elastic-www@$ESYNC_TARGET '/bin/bash -l -c "/home/elastic-www/www/manage.py assets build"'
  echo "REBUILT ASSETS  ::::::::::::::::::::::::::::::::::::::::::::::::::::::"
}
esync() {
  emulate bash
  echo "HG QREF IS CALLED ::::::::::::::::::::::::::::::::::::::::::::::::::::"
  # hg qref
  if [ -z $1 ]; then
    esync:update_cluster
  elif [ "$1" == "erd" ]; then
    esync:update_cluster
    esync:rebuild_assets
    esync:restart_services
  elif [ "$1" == "er" ]; then
    esync:update_cluster
    esync:restart_services
  elif [ "$1" == "e" ]; then
    esync:update_cluster
  elif [ "$1" == "r" ]; then
    esync:restart_services
  elif [ "$1" == "d" ]; then
    esync:rebuild_assets
  fi
  echo "FIN  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
  emulate zsh
}

export EHURI=https://api.alistair.elastichosts.com/
export EHAUTH=00000000-0000-0000-0000-000000000000:guildwars

export GOPATH=~/go
# export GOROOT=/usr/lib/go-1.12
PATH="$PATH:$GOPATH/bin"

update-host() {
  setopt ksh_glob
  rsync -rltpogDvzH --delete -e ssh ~alistair/repos/eh/code/host/lib/!(version).sh $1:/lib/elastic/lib/
  rsync -rltpogDvzH --delete -e ssh ~alistair/repos/eh/code/host/cmd/ $1:/lib/elastic/cmd/
}

alias uhvm="update-host myvmhost"
alias uhcont="update-host myconthost"
  
export PATH=$PATH:/home/alistair/.local/bin

# git config --global core.excludesfile ~/.gitignore_global

source ~/.cargo/env
