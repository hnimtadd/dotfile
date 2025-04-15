project() {
    # store the index file path
    projects_index="$HOME/.local/state/craftznake/projects.craftznake"

    local function ensure_index() {
        # if index already exists, return early
        [[ -f "$projects_index" ]] && return 0

        # create directory structure if it doesn't exist
        if [[ ! -d "$(dirname "$projects_index")" ]]; then
            mkdir -p "$(dirname "$projects_index")"
        fi

        # create empty index file
        touch "$projects_index"
        echo "created new projects index at $projects_index"
    }

    # ensure index exists before any processing
    ensure_index

    # function to add a project path
    local function padd() {
        local dir="${1:-.}"  # If no argument provided or ".", use current directory
        dir="$(pushd "$dir" >/dev/null 2>&1 && pwd -P && popd >/dev/null 2>&1)"  # Get absolute path without triggering cd

        if [ -d "$dir/.git" ]; then
            echo "$dir" >> "$projects_index"
            sort -u "$projects_index" -o "$projects_index"  # remove duplicates and sort
            echo "added project: $dir"
        else
            echo "Warning: Not a git repository"
            local confirm=""
            vared -p "Do you still want to add this project into index? (y/N): " confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                echo "$dir" >> "$projects_index"
                sort -u "$projects_index" -o "$projects_index"
                echo "Added project: $dir"
            else
                echo "Cancelled adding project"
            fi
        fi
    }

    # function to remove a project path
    local function prm() {
        if [ -f "$projects_index" ]; then
            local project=$(cat "$projects_index" | fzf)
            if [ -n "$project" ]; then
                sed -i bak "\#^$project\$#d" "$projects_index"
                echo "removed project: $project"
            fi
        fi
    }

    # function to search and cd into a project
    local function psearch() {
        if [ -f "$projects_index" ]; then
            local project=$(cat "$projects_index" | fzf)
            if [ -n "$project" ]; then
                cd "$project"
                zle reset-prompt
                zle kill-whole-line
            fi
        else
            echo "no projects index found. add projects using p add command."
        fi
    }

    local function plist() {
        if [[ -s "$projects_index" ]]; then
            echo "Indexed projects:"
            echo "----------------"
            local count=0
            while IFS= read -r project; do
                ((count++))
                if [[ -d "$project" ]]; then
                    echo "[$count] $project"
                else
                    echo "[$count] $project (not found)"
                fi
            done < "$projects_index"
            echo "----------------"
            echo "Total: $count projects"
        else
            echo "No projects in index. Add projects using p add"
        fi
    }

    local function print_help() {
        echo "Project Management Tool Usage:"
        echo "-----------------------------"
        echo "p                     - Interactive project search and navigation"
        echo "p add [directory]     - Add current or specified directory to projects"
        echo "p rm                  - Remove a project from the index"
        echo "p list                - List all indexed projects"
        echo "p --help              - Show this help message"
        echo
        echo "Note: Projects are stored in: $projects_index"
    }

    # main command logic
    case "$1" in
        "add")
            shift
            padd "$1"
            ;;
        "rm")
            prm
            ;;
        "list")
            plist
            ;;
        "--help"|"-h")
            print_help
            ;;
        *)
            psearch
            ;;
    esac
}
