function zbd {
    case $1 in
        -h | --help ) __zbd:help;;
                 -- ) __zbd:count $2;;
                 -* ) __zbd:illegal_opt $1;;
                 "" ) __zbd:cd 1;;
                  * ) __zbd:count $1;;
    esac
}

function __zbd:help {
<<EOF
usage: zbd [options] [directory name | number]

options:
    --              end of the options
    -h, --help      print this help

EOF
}

function __zbd:cd {
    local dest
    if [[ $1 -gt ${#${(ps:/:)${PWD}}} ]]; then
        __zbd:large_num_error $1
    else
        dest=`repeat $1 printf "../"`
        cd $dest
    fi
}

function __zbd:count {
    local num
    __zbd:get_dirs
    if [[ ${reply[(I)$1]} -eq 0 ]]; then
        expr "$1" + 1 >/dev/null 2>&1
        if [ $? -lt 2 ]; then
            __zbd:cd $1
        else
            __zbd:no_name_error $1
        fi
    else
        num=$(( ${#reply} - ${reply[(I)$1]} + 1 ))
        __zbd:cd $num
    fi
}

function __zbd:get_dirs {
    reply=("/" ${(ps:/:)${PWD}})
    reply=($reply[1,-2])
}

function __zbd:illegal_opt {
    print "zbd: illegal option ${1}"
    return 1
}

function __zbd:large_num_error {
    print "zbd: error: can not go up ${1} times (not enough parent directories)"
    return 1
}

function __zbd:no_name_error {
    print "zbd: error: no parent directory named '${1}'"
    return 1
}

compctl -V directories -K __zbd:get_dirs -M 'm:{[:lower:]}={[:upper:]}' zbd
