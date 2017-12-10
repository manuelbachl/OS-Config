########################################################################################################################
#                                                                                                                      #
#   OS-INDEPENDENT ALIASES                                                                                             #
#                                                                                                                      #
########################################################################################################################


#====================#
#   shell/terminal   #
#====================#

# set nano as default editor
alias n='nano'
alias sn='sudo nano'
alias edit='nano'
alias sedit='sudo nano'

# edit .zshrc
alias zshrc="sedit ~/.zshrc"

# edit .bashrc
alias bashrc="sedit ~/.bashrc"

# reload your zsh config
alias src="source ~/.zshrc"
alias reload='src'

# clear terminal
alias c='clear'

# show history
alias h='history'

# aliases for exit
alias q='exit'
alias quit='exit'


#====================#
#   system-related   #
#====================#

# show human readable disk space statistics
alias df='df -h'

# force sudo on reboot
alias reboot='sudo reboot'

#=================#
#   web-related   #
#=================#

# stop after sending count ECHO_REQUEST packets
alias ping='ping -c 5'

# do not wait interval 1 second on ping
alias fastping='ping -c 10 -s.2'

# get web server headers
alias header='curl -I'

# find out if remote server supports gzip / mod_deflate or not
alias headerc='curl -I --compress'

# resume wget by default
alias wget='wget -c'

# show all used ports
alias ports='netstat -tulanp'

#================#
#   navigation   #
#================#

# go to users home directory
alias home='cd $HOME'

# get rid of command not found
alias cd..='cd ..'

# a quick way to get out of current directory
alias ...='cd ../../..'
alias ....='cd ../../../..'
alias .....='cd ../../../../..'
alias ......='cd ../../../../../..'
alias .......='cd ../../../../../../..'
alias ........='cd ../../../../../../../..'
alias .........='cd ../../../../../../../../..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'
alias .7='cd ../../../../../../..'
alias .8='cd ../../../../../../../..'
alias .9='cd ../../../../../../../../..'

# copy the current working directory to the clipboard (requires xclip to be installed)
alias cpwd='pwd | xclip -selection clipboard'


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


#=================================#
#   file/directory manipulation   #
#=================================#

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

# make file executable
alias ax="chmod a+x"

# give a file execute permissions
alias chx='chmod 755'

# give a file just read and write permissions
alias chr='chmod 644'


#====================#
#   key-management   #
#====================#

# generate public-keypair
alias genpub='ssh-keygen -t rsa -b 4096'

# show public key
alias spubkey='cat ~/.ssh/id_rsa.pub'
alias showpubkey='spubkey'

# copy public key to clipboard (requires xclip to be installed)
alias cpubkey='spubkey | xclip -selection clipboard'
alias copypubkey='cpubkey'

# show private key
alias sprivkey='cat ~/.ssh/id_rsa'
alias showprivkey='sprivkey'

# copy public key to clipboard (requires xclip to be installed)
alias cprivkey='sprivkey | xclip -selection clipboard'
alias copyprivkey='cprivkey'
