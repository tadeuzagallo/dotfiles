#!/bin/bash

dir=~/dotfiles

link_path() {
  echo ~/.$1
}

original_path() {
  echo "$dir/$1"
}

ln -s $dir/tmux-vim-select-pane /usr/local/bin
chmod +x /usr/local/bin/tmux-vim-select-pane

for file in config gitconfig oh-my-zsh tmux.conf vim xvimrc vimrc zshrc bashrc bash_login inputrc
do
  link=$(link_path $file)
  original=$(original_path $file)

  echo "$original -> $link"

  if [ -h $link ] || [ ! -e $link ]; then
    rm $link &> /dev/null;
    ln -s $original $link
  else
    while true;
    do
      read -p "File $link already exists. Do you want override it? (y/n)\n" yn
      case $yn in
        [Yy]* ) rm $link; ln -s $original $link; break;;
        [Nn]* ) break;;
      esac
    done
  fi
done

cp ./fonts/SourceCode-Powerline-Regular.otf ~/Library/Fonts
curl -L https://github.com/i-tu/Hasklig/releases/download/0.9/Hasklig-0.9.zip > ~/Library/Fonts

git submodule init
git submodule update

source $dir/install/dependencies.txt

vim +NeoBundleInstall +qall

~/.vim/bundle/YouCompleteMe/install.sh
