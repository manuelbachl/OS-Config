########################################################################################################################
#                                                                                                                      #
#   CUSTOM ALIASES                                                                                                     #
#                                                                                                                      #
########################################################################################################################

#========================#
#   load configuration   #
#========================#

source $HOME/custom-aliases/config.sh;


#=====================================#
#   including aliases and functions   #
#=====================================#

# sources os-dependent aliases
source $HOME/custom-aliases/alias-definitions/os-dependent.sh;

# sources os-independent aliases
source $HOME/custom-aliases/alias-definitions/os-independent.sh;

# sources functions
source $HOME/custom-aliases/alias-definitions/functions.sh;