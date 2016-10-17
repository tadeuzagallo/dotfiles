#!/bin/bash

pushd $(dirname $0) > /dev/null
DIR="$PWD"
popd > /dev/null

link_path() {
  echo ~/.$1
}

original_path() {
  echo "$DIR/rc/$1"
}

rm /usr/local/bin/tmux-vim-select-pane
ln -s $(original_path tmux-vim-select-pane) /usr/local/bin
chmod +x /usr/local/bin/tmux-vim-select-pane

for file in $(ls rc)
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
      read -p "File $link already exists. Do you want override it? [y/n]: " yn
      case $yn in
        [Yy]* ) rm -rf $link; ln -s $original $link; break;;
        [Nn]* ) break;;
      esac
    done
  fi
done

# link fonts
cp ./fonts/SourceCode-Powerline-Regular.otf ~/Library/Fonts

pushd ~/Library/Fonts > /dev/null
curl -L https://github.com/i-tu/Hasklig/releases/download/v1.0-beta/Hasklig-1.0-Beta.zip > Hasklig.zip
unzip Hasklig.zip
rm Hasklig.zip
popd > /dev/null

# install submodules
git submodule init
git submodule update

# Install brew.sh
which brew 2> /dev/null || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install brew dependencies
brew install zsh \
             zsh-completions \
             zsh-syntax-highlighting \
             zsh-history-substring-search \
             tmux \
             ack \
             macvim --env-std --override-system-vim \
             reattach-to-user-namespace \
             the_silver_searcher \
             wget \
             cmake \
             nvm

# Switch to ZSH
chsh -s /usr/local/bin/zsh
/usr/local/bin/zsh

# Install the latest stable version of node.js
nvm install stable

vim +NeoBundleInstall +qall
~/.vim/bundle/YouCompleteMe/install.sh
