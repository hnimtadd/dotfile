set -gx PATH $PATH /usr/local/bin
set -gx PATH $PATH /opt/homebrew/bin
set -gx PATH $PATH $(brew --prefix)/bin

if test -d $(brew --prefix python)/libexec/bin
    set -gx PATH $PATH $(brew --prefix python)/libexec/bin
end

set -gx LIBRARY_PATH $LIBRARY_PATH $(brew --prefix)/lib

# set homebrew not to auto update packages when install new package
set -gx HOMEBREW_NO_AUTO_UPDATE true
