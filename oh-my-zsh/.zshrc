# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

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
plugins=(git command-not-found docker alias-tips)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



############################
### OS-dependent Aliases ###
############################

# Get os name via uname
_myos="$(uname)"

# add alias as per os
# Darwin = MacOS
case $_myos in
    Linux)
        # install with apt-get
        alias apt-get="sudo apt-get"
        alias updatey="sudo apt-get -y"

        # update on one command
        alias update='sudo apt-get -y update && sudo apt-get -y upgrade'
        ;;
    Darwin)
        # open google chrome
        alias chrome="open -a \"Google Chrome\""
        ;;
    *)
        ;;
esac

##############################
### OS-independent aliases ###
##############################

# go to users home directory
alias home='cd $HOME'

# clear terminal
alias c='clear'

# add extra protection against mistakes
alias rm='rm -I'

# get rid of command not found
alias cd..='cd ..'

# a quick way to get out of current directory
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# use a long listing format
alias ll='ls -la'

# show hidden files
alias l.='ls -lad .* --color=auto'

# group directories first
alias lsa='ls -lAhF --group-directories-first'

# create parent directories on demand
alias mkdir='mkdir -pv'

# set nano as default
alias n='nano'
alias sn='sudo nano'
alias edit='nano'
alias sedit='sudo nano'

# stop after sending count ECHO_REQUEST packets
alias ping='ping -c 5'

# do not wait interval 1 second, go fast
alias fastping='ping -c 100 -s.2'

# get web server headers
alias header='curl -I'

# find out if remote server supports gzip / mod_deflate or not
alias headerc='curl -I --compress'

# resume wget by default
alias wget='wget -c'

# display the directory structure recursively in a tree format
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

# get xour public IP-address
alias ipinfo="curl ifconfig.me"

# make executable
alias ax="chmod a+x"

# edit .zshrc
alias zshrc="sedit ~/.zshrc"

# reload your zsh config
alias src="source ~/.zshrc"

########################
### Helper functions ###
########################

# find what is using a particular port
# USAGE: whoisport 80
function whoisport() {
    if [ $# -lt 1 ];
    then
        echo 'USAGE: whoisport {PORTNUMBER}';
    else
        port=$1;
        pidInfo=$(sudo fuser $port/tcp 2> /dev/null);
        if [[ ! -z $pidInfo ]];
        then
            pidInfoClean="$(echo -e $pidInfo | tr -d '[:space:]')"
            pid=$(echo $pidInfoClean | cut -d':' -f2);
            sudo ls -l /proc/$pid/exe;
        else
            echo 'port '$port' is not in use';
        fi
    fi
}

# short-hand mysql dump import
# USAGE: mysql-import {DB-NAME} {SQL-FILE}
function mysql-import() {
    if [ $# -lt 2 ];
    then
        echo 'USAGE: mysql-import {DB-NAME} {SQL-FILE}';
    else
        mysql $1 < $2;
    fi
}

# find file
# USAGE: whereis {FILENAME}
function whereis() {
    if [ $# -lt 1 ];
    then
        echo 'USAGE: whereis {FILENAME}';
    else
        find . -name "$1*";
    fi
}

# create directory and cd into it, also creates parent directories
# USAGE: mcd {DIRECTORYNAME}
mcd() {
    if [ $# -lt 1 ];
    then
        echo 'USAGE: mcd {DIRECTORYNAME}';
    else
        mkdir -pv "$1";
        cd "$1";
    fi
}

# cd into directory and list contents
# USAGE: cls {DIRECTORYNAME}
cls() {
    if [ $# -lt 1 ];
    then
        echo 'USAGE: cls {DIRECTORYNAME}';
    else
        cd "$1";
        ls;
    fi
}

# cd into directory and list contents (detailed
# USAGE: cls {DIRECTORYNAME}
cll() {
    if [ $# -lt 1 ];
    then
        echo 'USAGE: cls {DIRECTORYNAME}';
    else
        cd "$1";
        ll;
    fi
}

# make backup of file
# USAGE: backup {FILENAME} {ENDING}
backup() {
    if [ $# -lt 2 ];
    then
        if [ $# -lt 1 ];
        then
            echo 'USAGE: backup {FILENAME} {ENDING}';
        else
            cp "$1"{,.bak};
        fi
    else
        cp "$1"{,."$2"};
    fi
}

# extract any kind of archive
# USAGE: extract {FILENAME}
extract() {
    if [ $# -lt 1 ];
    then
        echo 'USAGE: extract {FILENAME}';
    else
        if [ -f $1 ] ; then
            case $1 in
                *.tar.bz2)
                    tar xjf $1
                    ;;
                *.tar.gz)
                    tar xzf $1
                    ;;
                *.bz2)
                    bunzip2 $1
                    ;;
                *.rar)
                    unrar e $1
                    ;;
                *.gz)
                    gunzip $1
                    ;;
                *.tar)
                    tar xf $1
                    ;;
                *.tbz2)
                    tar xjf $1
                    ;;
                *.tgz)
                    tar xzf $1
                    ;;
                *.zip)
                    unzip $1
                    ;;
                *.Z)
                    uncompress $1
                    ;;
                *.7z)
                    7z x $1
                    ;;
                *)
                    echo "'$1' cannot be extracted via extract()"
                    ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
    fi
}

# Sort by size
# USAGE: sbs
sbs() { du -b --max-depth 1 | sort -nr | perl -pe 's{([0-9]+)}{sprintf "%.1f%s", $1>=2**30? ($1/2**30, "G"): $1>=2**20? ($1/2**20, "M"): $1>=2**10? ($1/2**10, "K"): ($1, "")}e';}

# generate strong password
# USAGE: genpass {LENGTH}
genpass() {
    if [ $# -lt 1 ];
    then
        strings /dev/urandom | grep -o '[[:alnum:][:punct:]]' | head -n 30 | tr -d '\n';
    else
        strings /dev/urandom | grep -o '[[:alnum:][:punct:]]' | head -n "$1" | tr -d '\n';
    fi
    echo;
}
