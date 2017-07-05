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
TOUCH_DIRS=($VIMBACKUPDIR $VIMDIRECTORY)
# vim plugin directory
PLUGIN_PATH=~/.vim/bundle

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

# function to create some files and directories that should be present
function touch_files_and_dirs() {
  pushd "$HOME" no-output
  for touch_dir in "${TOUCH_DIRS[@]}"; do
  if [ ! -d "${touch_dir}" ]; then
      echo "creating ${touch_dir}"
      mkdir -p ${touch_dir}
  else
      echo "${touch_dir} already exists"
  fi
  done
}

function pathogeninstall() {
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
}

dotfiles
touch_files_and_dirs
pathogeninstall

# Vim plugins
git -C $PLUGIN_PATH/nerdtree.vim pull || git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree.vim
git -C $PLUGIN_PATH/tmuxline.vim pull || git clone https://github.com/edkolev/tmuxline.vim ~/.vim/bundle/tmuxline.vim
git -C $PLUGIN_PATH/lightline.vim pull || git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim
