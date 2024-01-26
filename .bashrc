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


alias ct=_code_tunnel
alias csci=_csci
alias csinit=_csci_init
