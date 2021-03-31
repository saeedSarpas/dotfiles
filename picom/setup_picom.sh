#!/usr/bin/env bash

picomdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${picomdir}/../helpers/logging.sh;
source ${picomdir}/../helpers/mycommands.sh;


picom_setup() {
  safe_mkdir "${HOME}/.config/picom";
  myCp "${picomdir}/picom.config" "${HOME}/.config/picom/picom.config"
}


setup_picom_main() {
  # TODO: check if picom is installed

  section 'picom';
  picom_setup;

  log "Restarting picom...";
  killall picom 2>&1 | log_stdout;
  killall compton 2>&1 | log_stdout;
  picom --config ${HOME}/.config/picom/picom.config 2>&1 | log_stdout;
}
