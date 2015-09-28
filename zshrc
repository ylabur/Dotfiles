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

##==-- vim --==##
VIMBACKUPDIR="$HOME/.vim/_backup"
VIMDIRECTORY="$HOME/.vim/_temp"

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

### VCS module required
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

### Colors and Prompt
prompt_opts=(cr percent subst)
setopt prompt_subst
autoload colors zsh/terminfo && colors
for color in BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval export PR_LIGHT_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval export PR_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
done
PR_RESET_COLOR="%{$reset_color%}"

export PROMPT='${PR_LIGHT_BLACK}[${PR_LIGHT_BLUE}%n${PR_LIGHT_BLACK}@${PR_RESET_COLOR}${PR_GREEN}%m${PR_LIGHT_BLACK}:${PR_LIGHT_GREEN}%2c${PR_LIGHT_BLACK}]${PR_RESET_COLOR}${PR_RED} %(!.#.$)${PR_RESET_COLOR} '
export RPROMPT='${PR_LIGHT_BLACK}(%D{%m-%d %H:%M}) [%?] ${vcs_info_msg_0_}${PR_RESET_COLOR}' # shows exit status of previous command
