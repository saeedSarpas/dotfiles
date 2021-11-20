#!/usr/bin/env bash
# zaliases utils

function fuzzy_select() {
  local usage='usage: fuzzy_select command [args]';
  if [[ ! -n "$1" ]]; then echo $usage; return; fi

  while getopts ":h" opt; do
    case $opt in
      h) echo $usage 1>&2: return ;;
      *) continue;;
    esac
  done

  local item=$("$@" | fzf --ansi --color=16 --layout=reverse --inline-info);
  echo "${before} ${item} ${after}";
}

function to_term_buffer() {
  local usage='usage: to_term_buffer command';
  if [[ -n "$1" ]]; then local _command="$1"; else echo $usage; return; fi

  print -z $(echo ${_command} |  awk '{$1=$1;print}');
}

function _choose_file() {
  if [[ -n "$1" ]]; then local _dir="$1"; else local _dir="."; fi;

  local _files=`find ${_dir} -type f -not -path './node_modules*' \
    -a -not -path '*.git*'               \
    -a -not -path './coverage*'          \
    -a -not -name '*~'`

  local _file=$(fuzzy_select echo ${_files})
  echo ${_file}
}
