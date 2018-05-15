# zbd

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
For example, when you want to ignore case, add `zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'` in your `.zshrc`.
To make available the completion system, you have to put the following lines in your `.zshrc` before loading `zbd`.

```
autoload -Uz compinit
compinit
```


## Usage

    zbd [directory name | number]

### Options

    -h  --  print help


## Installation
### Manually
Put `zbd.zsh` file somewhere you want to install, and add the following line in your `.zshrc`.

```
source  <INSTALL_DIR>/zbd.zsh
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
