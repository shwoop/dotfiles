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
plugins=(python git)

# User configuration

# export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"
# export PATH=$PATH

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

# virtualenv
source ~/.local/bin/virtualenvwrapper.sh


# django debug flag
export DJ_DEBUG="True"

# export LESS="-x4"

alias apt-up="sudo apt-get update -qq && sudo apt-get upgrade && sudo snap refresh"

# alias dctest="docker-compose -f docker-compose.yml -f docker-compose.test.yml run api python manage.py test"

# Balls out!
# Attempt to find a docker compose test command in readme and run it!
# alias dctest="$(sed -n 's/.*\(docker.*manage.py test\)/\1/p' README.md | sed 's/exec/run/' | sed 's/`//')"


dctd() {
  # Docker Contain Test Django
  # Try to identify the django based docker test command in the readme
  echo "$(sed -n 's/.*\(docker.*manage.py test\)/\1/p' README.* | sed 's/exec/run/' | sed 's/`//')"
}

dct() {
  # Docker Contain Test
  # Try to identify any docker test command in the readme
  echo "$(sed -n 's/.*\(docker.* test\)/\1/p' README.* | sed 's/exec/run/' | sed 's/`//')"
}

# Docker compose test command from jenkins
alias dcpt="docker-compose -f docker-compose.yml -f docker-compose.test.yml exec -T api coverage run manage.py test --settings=purpletrac.settings.jenkins --parallel --noinput --verbosity 2"

# git tidy up branches
gitbranch() {
  for branch in `git branch | grep -v -e master -e release -e '*'`; do
    echo ">>> attempting to tidy up branch: $branch"
    git branch -d $branch
  done
}

getreports() {
    rsync -zr 10.45.20.106:performance-tests/purpletrac/locust/reports/ ~/Documents/performance_reports/
}

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

export PATH=$PATH:~/go/bin/
export PATH=$PATH:$HOME/.cargo/bin

source ~/.cargo/env
