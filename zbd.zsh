function zbd {
    : ${_ZBD_NUM_DIR:=${#${(ps:/:)${PWD}}}}

    case $1 in
        ("-h"|"--help")
            __zbd:help;;
        ("")
            __zbd:cd 1;;
        (*)
            __zbd:count $1;;
    esac
}

function __zbd:help {
<<EOF
Usage: zbd [Directory_name | Number]

Startup:
    -h, --help      print this help
EOF
}

function __zbd:cd {
    local dist
    if [[ $1 -gt ${_ZBD_NUM_DIR} ]]; then
        __zbd:large_num_error $1
    fi
    dest=`repeat $1 printf "../"`
    cd $dest
    return 0
}

function __zbd:count {
    local num
    __zbd:get_parents
    if [[ ${_ZBD_PARENTS[(I)$1]} -eq 0 ]]; then
        expr "$1" + 1 >/dev/null 2>&1
        if [ $? -lt 2 ]
        then
            __zbd:cd $1
        else
            __zbd:no_name_error $1
        fi
    else
        num=$(( $_ZBD_NUM_DIR - ${_ZBD_PARENTS[(I)$1]} ))
        __zbd:cd $num
    fi
}

function __zbd:get_dirs {
    __zbd:get_parents
    reply=( $_ZBD_PARENTS )
}

function __zbd:get_parents {
    typeset -g -a _ZBD_PARENTS
    local i
    for i in {2..$((${_ZBD_NUM_DIR}+1))}; do
        _ZBD_PARENTS=( $_ZBD_PARENTS "`echo $PWD | cut -d'/' -f$i`" )
    done
    _ZBD_PARENTS=( "/" $_ZBD_PARENTS )
}

function __zbd:large_num_error {
    print "zbd: Error: Can not go up ${1} times (not enough parent directories)"
    return 1
}

function __zbd:no_name_error {
    print "zbd: Error: No parent directory named '${1}'"
    return 1
}

compctl -V directories -K __zbd:get_dirs zbd
