########################################################################################################################
#                                                                                                                      #
#   HELPER-FUNCTIONS                                                                                                   #
#                                                                                                                      #
########################################################################################################################

#=================#
#   conversions   #
#=================#
# convert string to int
function toint {
    local -i num="10#${1}"
    echo "${num}"
}


#=================#
#   web-related   #
#=================#

# find what is using a particular port
# USAGE: whoisport 80
function whoisport() {
    if [ $# -lt 1 ];
    then
        echo 'USAGE: whoisport {PORTNUMBER}';
    else
        port=$1;
        local -i portNum=$(toint "${port}" 2>/dev/null);
        if (( $portNum < 1 || $portNum > 65535 ));
        then
            echo $port' is not a valid port (must be an integer between 1 and 65535)';
        else
            pidInfo=$(sudo fuser $port/tcp 2> /dev/null);
            if [[ ! -z $pidInfo ]];
            then
                pidInfoClean="$(echo -e $pidInfo | tr -d '[:space:]')"
                pid=$(echo $pidInfoClean | cut -d':' -f2);
                sudo ls -l /proc/$pid/exe;
            else
                if ! lsof -i:$port
                then
                    echo 'port '$port' is not in use';
                fi
            fi
        fi
    fi
}


#===============#
#   databases   #
#===============#

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


#================#
#   navigation   #
#================#

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


#============================#
#   list files/directories   #
#============================#

# Sort by size
# USAGE: sbs
sbs() { du -b --max-depth 1 | sort -nr | perl -pe 's{([0-9]+)}{sprintf "%.1f%s", $1>=2**30? ($1/2**30, "G"): $1>=2**20? ($1/2**20, "M"): $1>=2**10? ($1/2**10, "K"): ($1, "")}e';}


#================================#
#   file/directory manipulaion   #
#================================#

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


#==============#
#   archives   #
#==============#

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


#===============#
#   utilities   #
#===============#

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

# shows uptime using a shorter formula
myuptime () {
  uptime | awk '{ print "Uptime:", $3, $4, $5 }' | sed 's/,//g';
  return;
}