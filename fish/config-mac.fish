set -gx PATH $PATH /usr/local/bin
set -gx PATH $PATH /opt/homebrew/bin
set -gx PATH $PATH $(brew --prefix)/bin

set -gx LIBRARY_PATH $LIBRARY_PATH $(brew --prefix)/lib
