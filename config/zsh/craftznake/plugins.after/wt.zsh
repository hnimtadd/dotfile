wt() {
    [[ $# -eq 0 ]] && die "No command specified. Available commands: new, jump, prune, list" 1

    case $1 in
        help)
            wt_help
        ;;
        rm)
            shift
            wt_rm "$@"
        ;;
        new)
            shift
            wt_new "$@"
            ;;
        jump)
            shift
            wt_jump "$@"
            ;;
        prune)
            wt_prune
            ;;
        list)
            wt_list
            ;;
        *)
            die "Unknown command: $1. Available commands: new, jump, prune, list" 1
            ;;
    esac
}

wt_new() {
    wt_new_help() {
        echo "Usage: wt new <branch> <base> <path>"
        echo "  new <branch> <base> <path> - Create a new worktree from a branch"
    }

    update_upstream() {
        local branch="$1"
        [[ -z "$branch" ]] && die "Branch name required for update_upstream"

        # get remote name of the repo, separated by newlines
        local remotes=$(git remote show)
        [[ -z "$remotes" ]] && die "No git remotes found"

        # loop through remotes
        for remote in $remotes; do
            # check if branch exists on remote
            if [[ -n "$(git ls-remote --heads "$remote" "$branch")" ]]; then
                run_command "Setting upstream branch to '$remote/$branch'" git branch --set-upstream-to="$remote/$branch" $branch
                if [[ $? -ne 0 ]]; then
                    die "STOPPED" 1
                    return 1
                fi
            else
                echo "Branch '$branch' not found on remote '$remote', skipping upstream setting"
            fi
        done
    }
    # parse to check if first arg is help
    if [[ $1 == "help" ]]; then
        wt_new_help
        return 1
    fi

    if [[ $# -lt 3 ]]; then
        wt_new_help
        return 1
    fi

    branch=$1
    base=$2
    new_path=$3
    setup_colors

    # check if branch already exists
    if [[ -n "$(git branch --list "$branch")" ]]; then
        run_command "Generating new worktree from existing branch: $branch" git worktree add "$new_path" "$branch"
        if [[ $? -ne 0 ]]; then
            die "STOPPED" 1
            return 1
        fi
    else
        run_command "Generating new worktree: $new_path" git worktree add -b "$branch" "$new_path" "$base"
        if [[ $? -ne 0 ]]; then
            die "STOPPED" 1
            return 1
        fi
    fi

    msg "${GRAY}Moving into worktree: $new_path${NOFORMAT}"
    cd "$new_path"
    update_upstream "$branch"
    msg "${GREEN}Success.${NOFORMAT}"
}


wt_help() {
    echo "Usage: wt <command> [options]"
    echo "Commands:"
    echo "  new <branch> <base> - Create a new worktree from a branch"
    echo "  jump <worktree> - Jump to a worktree"
    echo "  rm <worktree>   - Remove a worktree"
    echo "  prune           - Prune prunable worktree"
    echo "  list            - list worktrees"
}

wt_jump() {
    wt_jump_help() {
        echo "Usage: wt jump <worktree-name>"
    }
    # parse to check if first arg is help
    if [[ $1 == "help" ]]; then
        wt_jump_help
        return 1
    fi

    ## Check if exactly one argument is provided
    if [[ $# -ne 1 ]]; then
        wt_jump_help
        return 1
    fi

    worktree=$1
    get_path(){
        match=$1
        # get the path from the line
        wt_path=$(echo "$match" | cut -d ':' -f 1)
        # trim spaces
        wt_path=$(echo "$wt_path" | xargs)
        echo "$wt_path"
    }
    setup_colors

    # Get paths and store them in an array
    # Use mapfile or readarray to properly handle the output
    paths=()

    while IFS= read -r line; do
        # ignore the first line
        if [[ $line == "" ]]; then
            continue
        fi
        paths+=("$line")
    done < <(git worktree list | awk -v pattern="$worktree" 'BEGIN{IGNORECASE=1}
        $3 ~ pattern {
            printf "%-70s:\t%40s\n", $1, $3
        }')
    count=${#paths[@]}

    # Check if 1 path is matching or more than 1
    if [[ $count -gt 1 ]]; then
        echo "Multiple paths found for worktree '$worktree':"
        # Print all matching paths
        echo >&2 -e  "${CYAN}=======================================================================${NOFORMAT}"
        counter=1 # start from 1
        for ele in "${paths[@]}"; do
            echo >&2 -e  "$counter: $ele"
            counter=$((counter + 1))
        done
        echo >&2 -e "${CYAN}=======================================================================${NOFORMAT}"
        # user input to select one
        echo -n "Please select one: "
        read selection
        new_path=$(get_path "${paths[$selection]}")
    elif [[ $count -eq 1 ]]; then
        new_path=$(get_path "${paths}")
    else
        die "Cannot find path for worktree '$worktree', available worktrees:" 1
        echo >&2 -e  "${CYAN}=======================================================================${NOFORMAT}"
        wt_list
        echo >&2 -e  "${CYAN}=======================================================================${NOFORMAT}"
        return 1
    fi

    echo >&2 -e  "${GREEN}moving to $new_path${NOFORMAT}"
    # user input to select one
    cd "$new_path"
}

wt_prune() {
    git worktree prune
}

wt_list() {
    git worktree list
}

wt_rm() {
    wt_rm_help() {
        echo "Usage: wt rm <worktree-name>"
    }
    # parse to check if first arg is help
    if [[ $1 == "help" ]]; then
        wt_rm_help
        return 1
    fi

    ## Check if exactly one argument is provided
    if [[ $# -ne 1 ]]; then
        wt_rm_help
        return 1
    fi

    worktree=$1

    # get the string include paths on multiple lines, and parse it into an array
    # This will:
    # 1. Run git worktree list and perform grep to find the line that contains the worktree name
    # 2. Parse line into array array, each element is a array with 2 elements, first is path, second is worktree
    get_path(){
        match=$1 # path:worktree
        wt_path=$(echo "$match" | cut -d ':' -f 1)
        return "$wt_path"
    }
    path_array=($(git worktree list | awk 'BEGIN{IGNORECASE=1} $3 ~ /'$worktree'/ {print $1 ":" $3}'))
    count=${#path_array[@]}

    # Check if 1 path is matching or more than 1
    if [[ $count -gt 1 ]]; then
        echo "Multiple paths found for worktree '$worktree':"

        # Print all matching paths
        for i in "${!path_array[@]}"; do
            echo "$i: ${path_array[$i]}"
        done
        # user input to select one
        read -p "Please select one: " i
        rm_path=$(get_path "${path_array[$i]}")
    # if only one path is matching, use it
    elif [[ $count -eq 1 ]]; then
        rm_path=$(get_path "${path_array[0]}")
    else
        die "Cannot find path for worktree '$worktree'" 1
        return 1
    fi

    run_command "Pruning the worktree" "$rm_path" rm $rm_path
    if [[ $? -ne 0 ]]; then
        die "STOPPED" 1
        return 1
    fi
}
