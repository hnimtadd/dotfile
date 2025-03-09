# Define the base path for your modules
MODULES_BASE_PATH="$ZSH_ROOT"
tput="/usr/bin/tput"

# Function to import modules
import() {
    local module_name="$1"
    local module_file="${MODULES_BASE_PATH}/${module_name}"

    # Check if the module file exists
    if [[ -f "$module_file" ]]; then
        source "$module_file"
    else
        echo "Module ${module_name} not found at $module_file"
        return 1  # Return an error code if the module is not found
    fi
}

append_path_if_not_exists() {
  local dir=$1
  if [[ -d "$dir" && ! ":$PATH:" =~ ":$dir:" ]]; then
      path+=$dir
  fi
}

cleanup() {
    trap - SIGINT SIGTERM ERR EXIT
    tput cnorm # enable cursor
    # script cleanup here
}

setup_colors() {
    if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
        # shellcheck disable=SC2034
        NOFORMAT='\033[0m' GRAY='\033[0;90m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
    else
        # shellcheck disable=SC2034
        NOFORMAT='' GRAY='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
    fi
}

msg() {
    echo >&2 -e "${1-}"
}

info() {
    msg "${GRAY}[INFO]${NOFORMAT} ${1-}"
}

die() {
    if [ "$#" -gt 0 ]; then
        msg "$1"
    fi
    return "${2-1}" # default exit status 1
}

function spinner() {
    # make sure we use non-unicode character type locale
    local LC_CTYPE=C
    local pid=$1 # Process Id of the previous running command
    local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
    local charwidth=3
    local TPUT_CMD

    # Find tput command
    if [ -x "/usr/bin/tput" ]; then
        TPUT_CMD="/usr/bin/tput"
    elif command -v tput >/dev/null 2>&1; then
        TPUT_CMD="tput"
    else
        TPUT_CMD=""
    fi

    local i=0
    # Only use tput if available
    if [ -n "$TPUT_CMD" ]; then
        $TPUT_CMD civis # cursor invisible
    fi

    while kill -0 "$pid" 2>/dev/null; do
        local i=$(((i + charwidth) % ${#spin}))
        printf >&2 "%s" "${spin:$i:$charwidth}"
        printf >&2 "\b"
        sleep .1
    done

    if [ -n "$TPUT_CMD" ]; then
        $TPUT_CMD cnorm # cursor normal
    fi

    wait "$pid" # capture exit code
    return $?
}

run_command() {
    local message=$1
    shift
    echo >&2 -ne "$message \n"

    # Create a temporary file for error output
    local temp_err=$(mktemp)

    # Run command in subshell, redirect stderr to temp file
    set +m
    {("$@" 2>"$temp_err") &}
    local pid=$!

    # Run spinner while command executes
    spinner $pid
    local exit_code=$?
    set -m

    if [ $exit_code -eq 0 ]; then
        echo >&2 -e " ${GREEN}Done.${NOFORMAT}"
        rm "$temp_err"
    else
        echo >&2 -e " ${RED}FAILED.${NOFORMAT}"
        # Print error messages if they exist
        if [ -s "$temp_err" ]; then
            echo >&2 -e "${RED}Error output:${NOFORMAT}"
            echo >&2 -e "${RED}--------------------------------${NOFORMAT}"
            cat "$temp_err" >&2
            echo >&2 -e "${RED}--------------------------------${NOFORMAT}"
        fi
        rm "$temp_err"
        return 1
    fi
}
