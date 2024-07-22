if type -q node
    set -gx PATH $PATH node_modules/.bin
end

if type -q java
    # set -gx JAVA_HOME /usr/lib/jvm/default
    set -gx PATH $PATH $JAVA_HOME/bin
end

if type -q yarn
    set -gx PATH $PATH ~/.yarn/bin
end

if test -d $HOME/.android
    # Android studio
    set -gx ANDROID_HOME $HOME/Library/Android/sdk
    set -gx PATH $PATH $ANDROID_HOME/emulator
    set -gx PATH $PATH $ANDROID_HOME/platform-tools
    set -gx PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin
end



if type -q conda
    status is-interactive && eval conda "shell.fish" hook $argv | source
end

if type -q goenv
    set -gx GOENV_ROOT $HOME/.goenv
    set -gx PATH $GOENV_ROOT/bin $PATH
    goenv init - | source
    set -gx PATH $GOROOT/bin $PATH
    set -gx PATH $PATH $GOPATH/bin
end

if test -d $HOME/.jenv
    set -gx PATH $PATH $HOME/.jenv/bin
    status --is-interactive; and jenv init - | source
end

set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.k,rew/bin; or set -gx PATH $PATH $HOME/.krew/bin

if type -q go
    function gocover ()
        # visual cover function for go test
        set t "/tmp/go-cover.$fish_pid.tmp"
        go test -coverprofile=$t $argv && go tool cover -html=$t && unlink $t
    end
end

if type -q minikube
    alias kubectl 'minikube kubectl --'
end

# Run github action locally
if type -q act
    alias act "act --container-architecture linux/amd64"
end

if type -q git
    # git cli alias
    alias gdh "git diff HEAD"
    alias gpush "git push"
    alias gpull "git pull"
    alias gcm "git commit -m "
    alias gadd "git add"
end

if test -d $HOME/Project
    alias dev "cd $HOME/Project/Development"
end

if test -e "$HOME/.dnenv/env"
    bass source "$HOME/.dnenv/env"
end


if test -d $HOME/Project/Learn
    alias learn "cd $HOME/Project/Learn"
end

if test -d $HOME/.slack
    set -gx PATH $PATH $HOME/.slack/bin
end

if test -d $HOME/.deno
    set -gx PATH $PATH $HOME/.deno/bin
end

if type -q nvm
    set -gx nvm_default_version v20.10.0
end
