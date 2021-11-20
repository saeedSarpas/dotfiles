#!/usr/bin/env bash
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${HOME}/.zaliases.d/utils.sh;

# :n - navigation
fnction _navigate_help() {
  local _command=$(fuzzy_select echo "${_navigate_options}");
  print -z $_command;
}

read -r -d '' _navigate_options << EOM
cd /vol/hobbes/hobbesraid/saeed
cd /net/galaxy-data/export/galaxydata/saeed
cd /net/galaxy-data/export/galaxy/shared/MUSE/noBackup/user/saeed
EOM

alias :n=_navigate_help;
