alias gl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"
alias gdh="git diff HEAD"
alias rg="grep rg"

if [[ -d "$HOME/.cfg" ]];then
    config() {
    case $1 in
        add)
            if [[ $2 == "all" ]]; then
                git --git-dir=$HOME/.cfg/ --work-tree=$HOME add $(git --git-dir=$HOME/.cfg/ --work-tree=$HOME diff --name-only --relative)
            else
                git --git-dir=$HOME/.cfg/ --work-tree=$HOME add $2
            fi
        ;;
    sync)
      # Show the diff
      changes=$(git --git-dir=$HOME/.cfg/ --work-tree=$HOME diff HEAD --name-only)
      # Check if there are no changes
      if [[ -z $changes ]]; then
        echo "No changes to sync."
        return
      fi

      git --git-dir=$HOME/.cfg/ --work-tree=$HOME status -v -v

      # Ask the user to proceed
      echo -n "Do you want to proceed with the sync (Y/n)? "
      read confirm
      # Default is y
      confirm=${confirm:-Y}

      if [[ $confirm == "y" || $confirm == "Y" ]]; then
        # Add all changes
        git --git-dir=$HOME/.cfg/ --work-tree=$HOME add $(git --git-dir=$HOME/.cfg/ --work-tree=$HOME diff --name-only --relative)

        # Ask the user for a commit message
        echo -n "Enter commit message: "
        read commit_msg

        # Check if a commit message is provided
        if [[ -n $commit_msg ]]; then
          git --git-dir=$HOME/.cfg/ --work-tree=$HOME commit -m "$commit_msg"
        else
          echo "Commit message is required. Aborting."
        fi
      else
        echo "Sync canceled."
      fi
      ;;
        *)
        git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
        ;;
    esac
    }
fi
