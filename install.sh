#!/usr/bin/env zsh
####
# Dotfiles/meta/install.sh
# simple script to link my dotfiles into $HOME
# @author Jake Teton-Landis <just.1.jake@gmail.com>
#
# Usage:
# ~/.dotfiles/meta/install.sh
####

# if any command gives a nonzero return code, exit the script
set -e

# location of this (install.sh) file
DOTFILES_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# list of files to link into homedir
DOTFILES=(gitconfig gitignore_global tmux.conf vimrc zshrc)
VIMDIRS=($VIMBACKUPDIR $VIMDIRECTORY)

# hide command output
alias -g no-output=">/dev/null 2>&1"

# link basic files
function dotfiles () {
  pushd "$HOME" no-output
  for file in "${DOTFILES[@]}"; do
    if [ ! -f "$HOME/${file}" ]; then
      echo "Linking .dotfiles/${file} -> ~/.${file}"
      if [ ! -h ".${file}" ] || \
         [ "$(readlink .${file})" != "$DOTFILES_DIR/${file}" ]; then
        ln -s "$DOTFILES_DIR/${file}" ".${file}"
      fi
    else
      echo "skipped because file exists: ~/.${file}"
    fi
  done
}

function vimdirs() {
  pushd "$HOME" no-output
  for vimdir in "${VIMDIRS[@]}"; do
  if [ ! -d "${vimdir}" ]; then
      echo "creating ${vimdir}"
      mkdir -p ${vimdir}
  else
      echo "${vimdir} already exists"
  fi
  done
}

function vimplug() {
	curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  vim -c PlugInstall
}

dotfiles
vimdirs
vimplug
