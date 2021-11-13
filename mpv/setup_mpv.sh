#!/usr/bin/env bash

mpvdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source ${mpvdir}/../helpers/logging.sh
source ${mpvdir}/../helpers/mycommands.sh
source ${mpvdir}/../helpers/install.sh

setup_mpv_config() {
  safe_mkdir "${HOME}/config/mpv";
  myCp "${mpvdir}/input.conf" "${HOME}/.config/mpv/input.conf";
}

setup_mpv_main() {
  section 'MPV';

  install 'mpv' 'mpv' 'mpv';

  setup_mpv_config;
}

