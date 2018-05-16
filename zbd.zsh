# zbd - zsh plugin to go back the specific parent directory quickly
#
# Copyright (c) 2018 ryutok
#
# This software is released under the MIT License.
# https://github.com/ryutok/zbd/blob/master/LICENSE
#
# Author: ryutok (https://github.com/ryutok)
#
# Usage:
#     zbd [directory name | number]
#
# Option:
#     -h  --  print help

function zbd {
    local option OPTARG OPTIND
    while getopts ':h' option; do
        case $option in
            h )
                __zbd:help
                return;;
            * )
                __zbd:illegal_opt $OPTARG
                return;;
        esac
    done
    shift $(expr $OPTIND - 1)

    case $1 in
        "" ) __zbd:cd 1;;
         * ) __zbd:count $1;;
    esac
    return
}

# __zbd:cd - execute cd ../../...
#     arg. [1]: Number of '../'
function __zbd:cd {
    local dest
    if [[ $1 -gt ${#${(ps:/:)${PWD}}} ]]; then
        __zbd:large_num_error $1
    elif [[ $1 -eq 0 ]]; then
        __zbd:no_name_error $1
    else
        dest=`repeat $1 printf "../"`
        cd $dest
    fi
}

# __zbd:count - count how many '../' we need
#     arg. [1]: Parent directory name
function __zbd:count {
    local num
    __zbd:get_parents
    if [[ ${parents[(I)$1]} -eq 0 ]]; then
        expr "$1" + 1 >/dev/null 2>&1
        if [ $? -lt 2 ]; then
            __zbd:cd $1
        else
            __zbd:no_name_error $1
        fi
    else
        num=$(( ${#parents} - ${parents[(I)$1]} + 1 ))
        __zbd:cd $num
    fi
}

# __zbd:get_parents - return parent directory list
#     parents: parent directory list
function __zbd:get_parents {
    parents=("/" ${(ps:/:)${PWD}})
    parents=($parents[1,-2])
}

function __zbd:help {
<<EOF
Usage: zbd [directory name | number]

Options:
    -h  --  print help

EOF
}

function __zbd:illegal_opt {
    print "zbd: illegal option -- ${1}"
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

function _zbd {
    declare -a args
    args=(
        '-h[print help]'
        '1:parents:__zbd:add_parents'
    )
    function __zbd:add_parents {
        __zbd:get_parents
        _wanted -V values expl 'parents' compadd $parents
    }
    _arguments $args
}

compdef _zbd zbd
