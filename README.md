# zbd
Quickly go back to a specific parent directory instead of typing `cd ../../..` redundantly.

This is reimplementation of [Tarrasch/zsh-bd](https://github.com/Tarrasch/zsh-bd).


## What's different from Tarrasch/zsh-bd
### Ignore current directory
Current directory is not included in parent directory list.
For example, when you are in `~/aaa/bbb/ccc/aaa`, command `zbd aaa` means `cd ~/aaa`.

### Performance without argument
Command `zbd` without argument corresponds `zbd 1` and `cd ../`.
When you want to display usage, please execute `zbd -h` or `zbd --help`.


## Installation
### By zplug
Install [zplug](https://github.com/zplug/zplug) and add following line to your `.zshrc` file.

    zplug 'ryutok/zbd'

### By manual
Download `zbd.zsh` by running one of the following commands in your terminal.
Please change `<INSTALL_DIR>` to the directory which you want to install zbd.

via `curl`

    curl https://raw.githubusercontent.com/ryutok/zbd/master/zbd.zsh > <INSTALL_DIR>/zbd.zsh

via `wget`

    wget https://raw.githubusercontent.com/ryutok/zbd/master/zbd.zsh <INSTALL_DIR>/zbd.zsh

Then, add following line to your `.zshrc` file.

    . <INSTALL_DIR>/zbd.zsh


## Usage

    zbd [directory name | number]

### Example:

    $ pwd
    /home/user/aaa/bbb/ccc/ddd
    $ zbd bbb
    $ pwd
    /home/user/aaa/bbb
    $ zbd 2
    $ pwd
    /home/user
    $ zbd
    $ pwd
    /home
    $
