#!/bin/bash

dir=$(cd "$(dirname "$(readlink "$0")")" && pwd)
echo $dir

link_path() {
  echo ~/.$1
}

original_path() {
  echo "$dir/$1"
}

for file in config gitconfig oh-my-zsh tmux.conf vim vimrc xvimrc zshrc
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
