#!/usr/bin/env bash

termitedir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${termitedir}/../helpers/logging.sh;
source ${termitedir}/../helpers/mycommands.sh;

pre_setup_termite() {
  safe_mkdir "${HOME}/.config/termite";
  myCp "${termitedir}/termite.config" "${HOME}/.config/termite/config"
}

setup_termite_nord() {
  myAppend "${termitedir}/termite.nord.colors" "${HOME}/.config/termite/config"
}

setup_termite_main() {
  # TODO: Check if termite is installed!

  section 'termite';

  pre_setup_termite;

  while true; do
    echo "";
    echo "Choose a colorscheme:";
    echo "    n: Nord";
    echo "";

    read -p "Colorscheme? [n]  " cs;
    case $cs in
      [Nn])
        setup_termite_nord;
        break;;
      *) continue;;
    esac
  done

  log "Restarting termite...";
  killall -USR1 termite 2>/dev/null;
}
