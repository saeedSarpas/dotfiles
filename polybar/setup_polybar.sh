#!/usr/bin/env bash

polybardir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${polybardir}/../helpers/logging.sh;
source ${polybardir}/../helpers/mycommands.sh;


setup_polybar() {
  safe_mkdir "${HOME}/.config/polybar";

  myCp "${polybardir}/polybar.config" "${HOME}/.config/polybar/config";
  myCp "${polybardir}/polybar-launch.sh" "${HOME}/.config/polybar/launch.sh";

  chmod +x ${HOME}/.config/polybar/launch.sh;

  log "NB: illum package is needed for the brightness control";
}


setup_polybar_main() {
  # TODO: Check if polybar is installed!

  section 'polybar';
  setup_polybar;

  log "Restarting polybar...";

  killall polybar 2>/dev/null;
  ${HOME}/.config/polybar/launch.sh >/dev/null 2>&1 &
}
