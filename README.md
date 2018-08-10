# zbd

[![Build Status](https://travis-ci.org/ryutok/zbd.svg?branch=master)](https://travis-ci.org/ryutok/zbd)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

Quickly go back to the specific parent directory instead of typing `cd ../../..`.


## Demo
![GIF animation](demo.gif)


## zbd vs. [Tarrasch/zsh-bd](https://github.com/Tarrasch/zsh-bd)
### Ignore current directory
Current working directory is not included in the parent directory list.
For example, when you are in `~/aaa/bbb/aaa`, command `zbd aaa` means `cd ~/aaa` not `cd ~/aaa/bbb/aaa`.

### Easily move up 1 directory
Command `zbd` without argument corresponds `zbd 1` and `cd ../`.

### Support new completion system (`zstyle`)
You can change TAB completion performance using `zstyle` command.
For example, when you want to ignore case, add the following lines in your `.zshrc`.

```
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
```


## Usage

    zbd [directory name | number]

### Options

    -h  --  print help


## Installation
### Manually
Put `zbd` and `_zbd` files somewhere you want to install, and add the following lines in your `.zshrc`.

```
export fpath=( <INSTALL_DIR> $fpath )
autoload -Uz zbd
```

### Using zplug
If you use [zplug](https://github.com/zplug/zplug), add the following line to your `.zshrc`.

```
zplug 'ryutok/zbd'
```


## License
[MIT](https://github.com/ryutok/zbd/blob/master/LICENSE)


## Author
[ryutok](https://github.com/ryutok)
