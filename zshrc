#!/usr/bin/env zsh


#~~~~~~~~~~~~~~~~~~~~~~~~~#
#  Environment variables  #
#~~~~~~~~~~~~~~~~~~~~~~~~~#
setopt ALL_EXPORT                                                               # export all of these settings

##==-- standard stuff --==##
VISUAL=vim                                                                      # VISUAL is the right one to set for setting the editor
EDITOR="$VISUAL"                                                                # but EDITOR is often used by mistake

##==-- zsh --==##
HISTFILE="$HOME/.zsh/cache/`hostname`.zhistory"
HISTSIZE=130000
SAVEHIST=100000
CLICOLOR=1                                                                      # enable color in command line
# long ass LS_COLORS borrowed from https://github.com/mathiasbynens/dotfiles/blob/master/.aliases (Stack Oveflow 1550288)
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'


##==-- vim --==##
VIMBACKUPDIR="$HOME/.vim/_backup"
VIMDIRECTORY="$HOME/.vim/_temp"

##==-- vcs_info --==##
# PROMPT='${vcs_info_msg_0_}%# '
export PROMPT='${PR_LIGHT_BLUE}%n@%m${PR_GREEN}:%2c${PR_YELLOW}|${PR_RED}%(?..[%?])${PR_YELLOW}%(!.#.$)${PR_RESET_COLOR} '
# export RPROMPT='${PR_LIGHT_BLACK}(%D{%m-%d %H:%M}) [%?] ${vcs_info_msg_0_}${PR_RESET_COLOR}' # shows exit status of previous command
RPROMPT='${vcs_info_msg_0_}'

setopt NO_ALL_EXPORT                                                            # end export all


#~~~~~~~~~~~~~~~#
#  Zsh options  #
#~~~~~~~~~~~~~~~#
##==-- history settings --==##
setopt HIST_IGNORE_DUPS                                                         # ignore adjacent duplicate command lines in scrollback
setopt NO_HIST_VERIFY                                                           # do not review `sudo !!` before executing
setopt INC_APPEND_HISTORY                                                       # append, not replace, to the history file
setopt EXTENDED_HISTORY                                                         # provide timestamps in history
setopt HIST_EXPIRE_DUPS_FIRST                                                   # remove duplicates first before saving history
setopt HIST_IGNORE_SPACE                                                        # do not save command line if it has a leading space
setopt NO_SHARE_HISTORY                                                         # annoying when different terminals do different tasks

##==-- globbing --==#
setopt EXTENDED_GLOB                                                            # use cool zsh glob features (`ls **/filename`, etc)
setopt LONG_LIST_JOBS                                                           # list jobs in long format

##==-- vcs module --==##
autoload -Uz vcs_info                                                           # enable vcs module
setopt prompt_subst                                                             # set prompt substitution
zstyle ':vcs_info:*' enable git svn                                             # look for git and svn repos
zstyle ':vcs_info:git*' formats "%s  %r/%S %b (%a) %m%u%c "                     # information in the git prompt
# zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
# zstyle ':vcs_info:*' formats       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
# zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

### Colors and Prompt
# prompt_opts=(cr percent subst)
# setopt prompt_subst
autoload -U colors terminfo && colors
for color in BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval export PR_LIGHT_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval export PR_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
done
PR_RESET_COLOR="%{$reset_color%}"



#~~~~~~~~~~~~~~~#
#  Zsh options  #
#~~~~~~~~~~~~~~~#
##==-- pre-command --==##
precmd() {
  vcs_info
}


#~~~~~~~~~~~~~~~~~#
#  Miscellaneous  #
#~~~~~~~~~~~~~~~~~#
# emacs keybindings in command line
set -o emacs
