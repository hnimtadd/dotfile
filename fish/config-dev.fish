if type -q node
    set -gx PATH node_modules/.bin $PATH
end
#
if type -q java
    set -gx JAVA_HOME /usr/lib/jvm/default
    set -gx PATH $JAVA_HOME/bin $PATH
end
#
#
if type -q yarn
    set -gx PATH ~/.yarn/bin $PATH
end
#
if type -q nvm
    # NVM
    function __check_rvm --on-variable PWD --description 'Do nvm stuff'
        status --is-command-substitution; and return
        if test -f .nvmrc; and test -r .nvmrc
            nvm use
        else
        end
    end

    # set default node version with nvm
    set -gx nvm_default_version 20.10.0
end
#
#
if type -q go
    set -gx GOPATH $HOME/go
    set -gx PATH $GOPATH/bin $PATH
    set -gx ANTLR_JAR $HOME/.jar/antlr-4.9.2-complete.jar
    set -gx PATH $GOROOT/bin $PATH
    set -gx PATH $GOPATH/bin $PATH
end
#
if type -q goenv
    # setup goenv
    status --is-interactive; and goenv init - | source
end
#
if test -d $HOME/.android
    set -gx ANDROID_HOME $HOME/Library/Android/sdk
    # Android studio

    set -gx PATH $ANDROID_HOME/platform-tools $PATH
    set -gx PATH $ANDROID_HOME/build-tools $PATH
    set -gx PATH $ANDROID_HOME/tools $PATH
    set -gx PATH $ANDROID_HOME/tools/bin $PATH
    set -gx PATH $ANDROID_HOME/emulator $PATH
end
#
if type -q conda
    status is-interactive && eval conda "shell.fish" hook $argv | source
end
#
if type -q nvim
    command -qv nvim && alias vim nvim
    set -gx EDITOR nvim
else if type -q vim
    set -gx EDITOR vim
end

if type -q jenv
    status --is-interactive; and jenv init - | source
end
#
set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

set -gx PATH $PATH $HOME/.krew/bin
#
set -gx PATH ~/.config/scripts $PATH
#
function gocover ()
    # visual cover function for go test
    set t "/tmp/go-cover.$fish_pid.tmp"
    go test -coverprofile=$t $argv && go tool cover -html=$t && unlink $t
end

if type -q minikube
    alias kubectl 'minikube kubectl --'
end

# Run github action locally
if type -q act
    alias act "act --container-architecture linux/amd64"
end
