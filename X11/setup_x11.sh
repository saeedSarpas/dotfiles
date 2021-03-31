#!/usr/bin/env bash

x11dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${x11dir}/../helpers/logging.sh;
source ${x11dir}/../helpers/mycommands.sh;

x11_setup() {
  myCp "${x11dir}/Xresources" "${HOME}/.Xresources";
  myCp "${x11dir}/xinitrc" "${HOME}/.xinitrc";

}

setup_xresources_nord() {
  myAppend "${x11dir}/Xresources.nord.colors" "${HOME}/.Xresources";
}

setup_xresources_dpi() {
  if [ ! -n "$1" ]; then log "setup_xresources_dpi needs exactly one argument"; return; fi

  log "Setting up Xresources dpi = $1";
  echo "Xft.dpi: $1;" >>  ${HOME}/.Xresources;
}

setup_x11_main() {
  # TODO: check if x11 is installed

  section 'x11';
  x11_setup;

  while true; do
    echo "";
    echo "dpi:";
    echo "    h: High";
    echo "    l: Low";
    echo "";

    read -p "dpi? [h,l]  " dpi;
    case $dpi in
      [Hh])
        setup_xresources_dpi 256;
        break;;
      [Ll])
        setup_xresources_dpi 96;
        break;;
      *) continue;;
    esac
  done

  while true; do
    echo "";
    echo "Choose a colorscheme:";
    echo "    n: Nord";
    echo "";

    read -p "Colorscheme? [n]  " cs;
    case $cs in
      [Nn])
        setup_xresources_nord;
        break;;
      *) continue;;
    esac
  done

  log "Restarting Xresource";
  xrdb ~/.Xresources | log_stdout;
}
