#!/bin/bash

echo "make symbolic links to $HOME"
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# zplug/zplug install
curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh
