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
        alias updatey="sudo apt-get -y update"

        # update on one command
        alias update='sudo apt-get -y update && sudo apt-get -y upgrade'

        # uninstall packages including their data
        alias remove='sudo apt-get --purge remove'
        ;;
    Darwin)
        # open google chrome
        alias chrome="open -a \"Google Chrome\""
        ;;
    *)
        ;;
esac
