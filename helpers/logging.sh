#!/usr/bin/env bash

function get_time() {
  report_time=$(printf "[%s]" $(date "+%Y%m%d %H:%M:%S"))
  echo "${report_time}"
}

function section() {
  if [[ -n "$1" ]]; then title="$1"; else echo 'log function needs at least one argument'; exit; fi
  if [[ -n "$2" ]]; then desc=" [$2]"; else desc=''; fi

  echo ""
  echo "$(get_time) >>> ${title}${desc}" 1>&1
}


function log() {
  if [[ -n "$1" ]]; then msg="$1"; else echo 'log function needs at least one argument'; exit; fi
  if [[ -n "$2" ]]; then desc=" [$2]"; else desc=''; fi

  echo "$(get_time) ... ${msg}${desc}" 1>&1
}


function err() {
  if [[ -n "$1" ]]; then error_msg="$1"; else echo 'err function needs at least one argument'; exit; fi
  if [[ -n "$2" ]]; then error_desc=" ($2)"; else var_desc=''; fi

  report_time=$(get_time)

  echo "${report_time} [ERROR] ${error_msg}${error_desc}" 1>&2
}

log_stdout() {
  while IFS= read -r line
  do
    log "\$ $line"
  done
}

exec_status() {
  if [[ -n "$1" ]]; then local _status="$1"; else err "exactly 1 argument is needed!"; return; fi
  if [ "${_status}" -ne 0 ]; then err "[failed]"; else log "[done]"; fi
}
