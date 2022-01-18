#!/usr/bin/env bash
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${HOME}/.zaliases.d/utils.sh;

# :H - helpers

function _helpers_help() {
  local _command=$(fuzzy_select echo "${_helpers_options}" | awk '{$1=""; print $0}');

  to_term_buffer ${_command};
}

read -r -d '' _helpers_options << EOM
:Hld list directories

:Hw  watch -n 1 "<command>"
EOM

alias :H=_helpers_help;
alias :Hld=_list_directories_helper;
alias :Hw=_watcher_helper;

function _list_directories_helper() {
  find . -maxdepth 1 -mindepth 1 -type d  -not -path '*/\.git';
}

function _watcher_helper() {
  local usage='usage: _docker_logs flags';
  if [[ -n "$1" ]]; then local _cmd="$1"; else echo $usage; return; fi

  watch -n 1 "$_cmd"
}
