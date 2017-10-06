########################################################################################################################
#                                                                                                                      #
#   OS-DEPENDENT ALIASES                                                                                               #
#                                                                                                                      #
#                                                                                                                      #
#   uname-values currently covered:                                                                                    #
#     * Linux                                                                                                          #
#     * Darwin (MacOS)                                                                                                 #
#                                                                                                                      #
########################################################################################################################

# Get os name via uname
_myos="$(uname)"

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
