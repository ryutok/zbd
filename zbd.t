# vim:set filetype=sh:

# Test functions by shUnit2
#
# Copyright (c) 2018 ryutok
#
# Author: ryutok (https://github.com/ryutok)

SHUNIT_PARENT=$0

setUp() {
  export FPATH=$PWD:$FPATH
  autoload -Uz zbd

  rpath=`pwd`
  mkdir -p ${rpath}/aaa/bbb/-h/ccc/ddd/ccc
}

# Test for integer arguments
testIntArg() {
  # `zbd 0` should not corresponds to `cd ~`
  zbd 0 > /dev/null
  apath=`pwd`
  assertNotEquals $HOME $apath

  epath="${rpath}/aaa"
  cd ${rpath}/aaa/bbb
  zbd 1
  apath=`pwd`
  assertEquals $epath $apath

  epath="${rpath}"
  cd ${rpath}/aaa/bbb
  zbd 2
  apath=`pwd`
  assertEquals $epath $apath
}

# Test for the case without any argument
testNoArg() {
  epath="${rpath}/aaa"
  cd ${rpath}/aaa/bbb
  zbd 1
  apath=`pwd`
  assertEquals $epath $apath
}

# Test for strings arguments
testStrArg() {
  epath="${rpath}/aaa"
  cd ${rpath}/aaa/bbb
  zbd aaa
  apath=`pwd`
  assertEquals $epath $apath

  # ignore current working directory
  epath="${rpath}/aaa/bbb/-h/ccc"
  cd ${rpath}/aaa/bbb/-h/ccc/ddd/ccc
  zbd ccc
  apath=`pwd`
  assertEquals $epath $apath

  # in the case "-h" is the directory
  epath="${rpath}/aaa/bbb/-h"
  cd ${rpath}/aaa/bbb/-h/ccc/ddd/ccc
  zbd -- -h
  apath=`pwd`
  assertEquals $epath $apath
}

# Test for help message
testHelp() {
expected=`cat <<EOF
Usage: zbd [directory name | number]

Options:
    -h  --  print help

EOF
`
  actual=`zbd -h`
  assertEquals "$expected" "$actual"
}

# Test for error message
testError() {
  # no name error
  cd ${rpath}
  expected="zbd: error: no parent directory named '-h'"
  actual=`zbd -- -h`
  assertEquals "$expected" "$actual"

  # large number error
  cd ${rpath}
  expected="zbd: error: can not go up 999999 times (not enough parent directories)"
  actual=`zbd 999999`
  assertEquals "$expected" "$actual"
}

tearDown() {
  cd ${rpath}
  rm -r aaa
}

. ./shunit2/shunit2
