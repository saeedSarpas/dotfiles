#!/usr/bin/env bash
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${HOME}/.zaliases.d/utils.sh;

# :LB - Linux backlight

function _linux_backlight_help() {
  local _command=$(fuzzy_select echo "${_linux_backlight_options} | awk '{$1=""; print $0}'");

  to_term_buffer ${_command};
}

read -r -d '' _docker_options << EOM
:LBem sudo modprobe i2c-dev
:LBeg sudo ddcutil getvcp 10
:LBes sudo ddcutil setvcp 10
EOM

alias :LBem='sudo modprobe i2c-dev'
alias :LBeg='sudo ddcutil getvcp 10'
alias :LBes='sudo ddcutil setvcp 10 '
