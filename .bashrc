function _csci() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo -e "\033[34mUsage:\033[0m \033[32mcsci <exe_name> <arg1> <arg2> ... <options>\033[0m"
        echo -e "\033[34mOptions:\033[0m \033[33m-b | -B\033[0m runs executable from inside build directory"
        echo -e "\033[34mNote:\033[0m For \033[32mexe_name\033[0m use simply '\033[32mrun_app\033[0m' instead of './build/run_app' or './run_app'"
        return
    fi

    local build_dir=$(basename "$PWD")
    local exe_name=$1
    local original_dir="$PWD"
    local args=()
    local run_valgrind=false
    local run_inside_build=false

    shift

    while (( "$#" )); do
        case "$1" in
        -v|--verbose)
            run_valgrind=true
            shift
            ;;
        -b|--build)
            run_inside_build=true
            shift
            ;;
        *)
            args+=("$1")
            shift
            ;;
        esac
    done

    if [[ "$build_dir" != "build" ]]
    then
        cd build
    fi
    make || { echo "Build failed"; return 1; }
    exe_path="$PWD/$exe_name"
    if [[ ! -f "$exe_path" ]]
    then
        echo "Executable not found: $exe_path"
        return 1
    fi

    if [[ $run_inside_build = false ]]; then
        cd ..
    fi

    if [[ $run_valgrind = true ]]; then
        valgrind --tool=memcheck --leak-check=full $exe_path "${args[@]}"
    else
        $exe_path "${args[@]}"
    fi

    cd "$original_dir"
}

function _csci_init() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo -e "\033[34mUsage:\033[0m \033[32mcsinit\033[0m"
        echo -e "\033[34mPurpose:\033[0m Runs \033[32mcmake ..\033[0m inside build directory."
        return
    fi

    local build_dir=$(basename "$PWD")
    shift

    if [[ "$build_dir" == "build" ]]
    then
        :
    else
        cd build
        
    fi
    cmake ..
    cd ..
}
function _code_tunnel() {
    local command="/home/jovyan/code tunnel"
    echo "$command"
    eval "$command"
}
function _git_everything() {
    if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
        echo -e "\033[34mUsage:\033[0m \033[32mcgsit [message]\033[0m"
        echo -e "\033[34mDescription:\033[0m Adds all changes to the staging area,\033[33m commits them with the provided message,\033[0m and pushes the changes to the remote repository."
    return
fi


    set -e

    git add . || { echo "Failed to add changes to the staging area."; exit 1; }
    git commit -m "$1" || { echo "Failed to commit changes."; exit 1; }
    git push || { echo "Failed to push changes to the remote repository."; exit 1; }

    echo "Changes have been successfully added, committed, and pushed."
}
function _cshelp() {
    echo -e "\033[34mcsinit:\033[0m"
    eval "csinit -h"
    echo -e "\n\033[34mcsci:\033[0m"
    eval "csci -h"
    echo -e "\n\033[34mcsgit:\033[0m"
    eval "csgit -h"
}

alias cshelp=_cshelp
alias csgit=_git_everything
alias ct=_code_tunnel
alias csci=_csci
alias csinit=_csci_init

alias ls='ls --color=auto -h'
alias ll="ls -lhA"
alias du='du -h'