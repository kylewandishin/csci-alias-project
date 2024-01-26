function _csci() {
    local build_dir=$(basename "$PWD")
    local exe_name=$1
    local original_dir="$PWD"
    shift

    if [[ "$build_dir" == "build" ]]
    then
        :
    else
        cd build
        
    fi
    make || { echo "Build failed"; return 1; }
    exe_path="$PWD/$exe_name"
    if [[ ! -f "$exe_path" ]]
    then
        echo "Executable not found: $exe_path"
        return 1
    fi

    if [[ "${!#}" == "-b" || "${!#}" == "-B" ]]; then
        args="${@:1:$#-1}"
    else
        cd ..
        args="$@"
    fi
    $exe_path $args
    cd "$original_dir"
}
function _csci_init() {
    local build_dir=$(basename "$PWD")
    local exe_name=$1
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
        echo "Usage: _git_everything [message]"
        echo "Adds all changes to the staging area, commits them with the provided message, and pushes the changes to the remote repository."
        return
    fi

    set -e

    git add . || { echo "Failed to add changes to the staging area."; exit 1; }
    git commit -m "$1" || { echo "Failed to commit changes."; exit 1; }
    git push || { echo "Failed to push changes to the remote repository."; exit 1; }

    echo "Changes have been successfully added, committed, and pushed."
}

alias csgit=_git_everything
alias ct=_code_tunnel
alias csci=_csci
alias csinit=_csci_init
