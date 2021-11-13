#!/usr/bin/env bash

screendir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source ${screendir}/../helpers/logging.sh
source ${screendir}/../helpers/mycommands.sh
source ${screendir}/../helpers/install.sh

setup_screen_config() {
  myCp "${screendir}/screenrc" "${HOME}/.screenrc";
}

setup_screen_main() {
  section 'SCREEN';

  install 'screen' 'screen' 'screen';

  setup_screen_config;
}


