# dotfile

Personal working environment configuration for bash, vim, tmux, etc.

## Installation

1. Clone the repo
```
git clone https://github.com/hwpeng/dotfile.git
```

2. Bash
```
rm -f .bashrc
ln -s dotfile/.bashrc .
source .bashrc
```

2. Vim
```
cp -r dotfile/.vim .
rm -f .vimrc
ln -s dotfile/.vimrc .
vim -cmd '' -c ':PlugInstall' -c 'qa!'
```

3. Tmux
```
rm -f .tmux.conf
ln -s dotfile/.tmux.conf .
```
