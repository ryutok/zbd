# zbd
Quickly go back to a specific parent directory instead of typing `cd ../../..` redundantly.

This is reimplementation of [Tarrasch/zsh-bd](https://github.com/Tarrasch/zsh-bd).


## What's different from Tarrasch/zsh-bd
### Ignore current directory
Current directory is not included in the parent directory list.
For example, when you are in `~/aaa/bbb/ccc/aaa`, command `zbd aaa` means `cd ~/aaa`.

### Performance without argument
Command `zbd` without argument corresponds `zbd 1` and `cd ../`.
When you want to display usage, please execute `zbd -h` or `zbd --help`.


## Installation
### By zplug
Install [zplug](https://github.com/zplug/zplug) and add following line to your `.zshrc` file.
```
zplug 'ryutok/zbd'
```

### By manual
1. Download the latest source code from [releases](https://github.com/ryutok/zbd/releases) and uncompress the files.
2. Move the uncompressed directory `zbd-1.2` to the directory which you want to install zbd.
3. Add following line to your `.zshrc` file. Please change `<INSTALL_DIR>` to your install directory.
```
. <INSTALL_DIR>/zbd-1.2/zbd.zsh
```

## Usage

    zbd [options] [directory name | number]

    options:
        --              end of the options
        -h, --help      print this help

### Example:

    $ pwd
    /home/user/aaa/bbb/ccc/ddd
    $ zbd bbb
    $ pwd
    /home/user/aaa/-h/bbb
    $ zbd -- -h
    $ pwd
    /home/user/aaa/-h
    $ zbd 2
    $ pwd
    /home/user
    $ zbd
    $ pwd
    /home
    $
