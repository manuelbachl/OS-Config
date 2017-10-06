########################################################################################################################
#                                                                                                                      #
#   OS-INDEPENDENT ALIASES                                                                                             #
#                                                                                                                      #
########################################################################################################################


#====================#
#   shell/terminal   #
#====================#

# edit .zshrc
alias zshrc="sedit ~/.zshrc"

# reload your zsh config
alias src="source ~/.zshrc"

# clear terminal
alias c='clear'

# set nano as default editor
alias n='nano'
alias sn='sudo nano'
alias edit='nano'
alias sedit='sudo nano'


#=================#
#   web-related   #
#=================#

# get xour public IP-address
alias ipinfo="curl ifconfig.me"

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


#================#
#   navigation   #
#================#

# go to users home directory
alias home='cd $HOME'

# get rid of command not found
alias cd..='cd ..'

# a quick way to get out of current directory
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'
alias .7='cd ../../../../../../..'
alias .8='cd ../../../../../../../..'
alias .9='cd ../../../../../../../../..'

# copy the current working directory to the clipboard
alias cpwd='pwd | xclip -selection clipboard'


#============#
#   search   #
#============#

# quickly find files and directory
alias ff='find . -type f -name'
alias fd='find . -type d -name'


#============================#
#   list files/directories   #
#============================#

# use a long listing format
alias ll='ls -la'

# use a long listing format but human readable
alias lh='ls -lahXG'

# show hidden files
alias l.='ls -lad .* --color=auto'

# group directories first
alias lsa='ls -lAhF --group-directories-first'

# display the directory structure recursively in a tree format
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"


#================================#
#   file/directory manipulaion   #
#================================#

# create parent directories on demand
alias mkdir='mkdir -pv'

# add extra protection against mistakes
alias rm='rm -I'
alias rmr='rm -rI'
alias rmrf='rm -rfI'
alias cp='cp -iv'
alias mv='mv -i'


#======================#
#   file permissions   #
#======================#

# make executable
alias ax="chmod a+x"

# give a file execute permissions or just read and write
alias chx='chmod 755'
alias chr='chmod 644'
