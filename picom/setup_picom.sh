#!/usr/bin/env bash

picomdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${picomdir}/../helpers/logging.sh;
source ${picomdir}/../helpers/mycommands.sh;


picom_setup() {
  safe_mkdir "${HOME}/.config/picom";
  myCp "${picomdir}/picom.config" "${HOME}/.config/picom/picom.config"
}


setup_picom_main() {
  # TODO: check if picom-jonaburg-git is installed

  section 'picom';
  picom_setup;

  log "restarting picom";
  killall picom 2>/dev/null;
  killall compton 2>/dev/null;
  picom --config ${HOME}/.config/picom/picom.config 2>/dev/null &
}
