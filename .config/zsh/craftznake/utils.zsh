# Define the base path for your modules
MODULES_BASE_PATH="$ZSH_ROOT"

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
