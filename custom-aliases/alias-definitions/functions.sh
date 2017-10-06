########################################################################################################################
#                                                                                                                      #
#   HELPER-FUNCTIONS                                                                                                   #
#                                                                                                                      #
########################################################################################################################


#====================#
#   shell/terminal   #
#====================#

# print a separator banner, as wide as the terminal
function hr() {
    print ${(l:COLUMNS::=:)}
}


#=================#
#   conversions   #
#=================#
# convert string to int
function toint() {
    local -i num="10#${1}"
    echo "${num}"
}

# urlencode text
function urlencode() {
    echo -e $(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$1");
}

# create short urls via http://goo.gl using curl(1)
function zurl() {
    if [[ -z $1 ]];
    then
        print "USAGE: $0 <URL>";
    else
        if [ -z "$configGoogleApiKey" ];
        then
            echo -e 'No Google API Key defined!';
            echo -e '';
            echo -e 'You should set your Key in $HOME/custom-aliases/config.sh';
            echo -e 'Otherwise it could be that the daily limit for requests is reached and you do not receive a shortened URL';
            echo -e 'For further information take a look here: https://developers.google.com/url-shortener/v1/getting_started';
            api="https://www.googleapis.com/urlshortener/v1/url";
        else
            api="https://www.googleapis.com/urlshortener/v1/url?key=$configGoogleApiKey";
        fi
        url=$1;
        if [[ $1 =~ http(s|)://* ]];
        then
            url=$url;
        else
            url="http://$url";
        fi
        json="{\"longUrl\": \"$url\"}"
        data=$(curl --silent -H "Content-Type: application/json" -d $json $api);
        if [[ $data =~ '"id": "(http(s|)://goo.gl/[[:alnum:]]+)"' ]];
        then
            match="${match/ s/}"
            echo -e $match;
        else
            echo -e $data;
        fi
    fi
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

# get public ip
function myip() {
	local api
	case "$1" in
		"-4")
			api="http://v4.ipv6-test.com/api/myip.php"
			;;
		"-6")
			api="http://v6.ipv6-test.com/api/myip.php"
			;;
		*)
			api="http://v4v6.ipv6-test.com/api/myip.php"
			;;
	esac
	curl -s "$api"
	echo # Newline.
}
alias ipinfo='myip'


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
function cls() {
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
function cll() {
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
function sbs() { du -b --max-depth 1 | sort -nr | perl -pe 's{([0-9]+)}{sprintf "%.1f%s", $1>=2**30? ($1/2**30, "G"): $1>=2**20? ($1/2**20, "M"): $1>=2**10? ($1/2**10, "K"): ($1, "")}e';}


#================================#
#   file/directory manipulaion   #
#================================#

# create directory and cd into it, also creates parent directories
# USAGE: mcd {DIRECTORYNAME}
function mcd() {
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
function backup() {
    if [ $# -lt 2 ];
    then
        if [ $# -lt 1 ];
        then
            echo 'USAGE: backup {FILENAME} {ENDING}';
        else
            cp -a "$1" "${1}_$(date --iso-8601=seconds)"
        fi
    else
        cp "$1"{,."$2"};
    fi
}

# print the last ten modified files in the specified directory
# USAGE: lastmod {DIRECTORY}
function lastmod() {
    if [ $# -lt 1 ];
    then
        ls -lt ./ | head;
    else
        ls -lt $1 | head;
    fi
}

# copy a file to the clipboard from the command line (requires xclip to be installed)
# USAGE copyfile {FILENAME}
function copyfile() {
    if [ $# -lt 1 ];
    then
        echo 'USAGE copyfile {FILENAME}';
    else
        cat $1 | xclip -selection clipboard;
    fi
}

#==============#
#   archives   #
#==============#

# extract any kind of archive
# USAGE: extract {FILENAME}
function extract() {
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
# USAGE: passgen {LENGTH}
function passgen() {
    if [ $# -lt 1 ];
    then
        strings /dev/urandom | grep -o '[[:alnum:][:punct:]]' | head -n 30 | tr -d '\n';
    else
        strings /dev/urandom | grep -o '[[:alnum:][:punct:]]' | head -n "$1" | tr -d '\n';
    fi
    echo;
}
alias genpass='passgen'

# shows uptime using a shorter formula
function myuptime() {
    uptime | awk '{ print "Uptime:", $3, $4, $5 }' | sed 's/,//g';
    return;
}

# google for specified term in default browser
function google() {
    xdg-open "https://www.google.com/search?q=`urlencode "${(j: :)@}"`";
}

# launch an app
function launch() {
	type $1 >/dev/null || { print "$1 not found" && return 1 }
	$@ &>/dev/null &|
}
alias launch="launch " # expand aliases