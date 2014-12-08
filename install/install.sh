#!/bin/bash

dir=$(cd "$(dirname "$(readlink "$0")")" && pwd)
echo $dir

link_path() {
  echo ~/.$1
}

original_path() {
  echo "$dir/$1"
}

source $dir/dependencies.txt

mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

cp $dir/tmux-vim-select-pane /usr/local/bin
chmod +x /usr/local/bin/tmux-vim-select-pane

mkdir -p ~/Library/Fonts &> /dev/null
cp ./Source+Code+Pro+Regular+for+Powerline.otf ~/Library/Fonts &> /dev/null
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes &> /dev/null
cp ./RailsCasts.dvtcolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes &> /dev/null

for file in config gitconfig oh-my-zsh tmux.conf vim vimrc xvimrc zshrc zsh-syntax-highlighting zsh-history-substring-search
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

git submodule init
git submodule update

mkdir -p ~/.gem &>/dev/null