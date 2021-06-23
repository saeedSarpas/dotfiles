#!/usr/bin/env bash

rofidir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${rofidir}/../helpers/logging.sh;
source ${rofidir}/../helpers/mycommands.sh;
source ${rofidir}/../colors/nord.sh;

rofi_pre_setup() {
  safe_mkdir "${HOME}/.local/bin"

  safe_clean "${HOME}/.local/bin/rofi"
  myCp "${rofidir}/rofi" "${HOME}/.local/bin/rofi"

  safe_mkdir "${HOME}/.config/rofi"
  safe_clean "${HOME}/.config/rofi/myrofi.rasi"
  myCp "${rofidir}/myrofi.rasi" "${HOME}/.config/rofi/myrofi.rasi"
}

setup_rofi_nord() {
  log "Setting up Nord scheme"
  echo "color-normal: \"argb:00${nord_purple}, argb:ff${nord_white2}, argb:00${nord_purple}, argb:aa${nord_purple}, argb:00${nord_blue3}\";" >> ${HOME}/.config/rofi/myrofi.rasi;
  echo "color-urgent: \"argb:ff${nord_red}, argb:ff${nord_white2}, argb:00${nord_purple}, argb:00${nord_purple}, argb:ff${nord_blue3}\";" >> ${HOME}/.config/rofi/myrofi.rasi;
  echo "color-active: \"argb:00${nord_purple}, argb:ff${nord_white2}, argb:00${nord_purple}, argb:00${nord_purple}, argb:ff${nord_blue3}\";" >> ${HOME}/.config/rofi/myrofi.rasi;
  echo "color-window: \"argb:dd${nord_dark0}, argb:dd${nord_dark0}, argb:dd${nord_dark0}\";" >> ${HOME}/.config/rofi/myrofi.rasi;
}


setup_rofi_dpi() {
  if [ ! -n "$1" ]; then log "setup_rofi_dpi needs exactly one argument"; return; fi

  log "Setting up the dpi = $1";
  echo "dpi: $1;" >>  ${HOME}/.config/rofi/myrofi.rasi;
}

rofi_install_numix_icons() {
  safe_mkdir "${HOME}/.local/share/icons";

  git clone https://github.com/numixproject/numix-icon-theme-circle.git ${HOME}/.local/share/icons/Numix-Icons | log_stdout;

  myLn ${HOME}/.local/share/icons/Numix-Icons/Numix-Circle ${HOME}/.local/share/icons/Numix-Circle
}

rofi_post_setup() {

  echo "}" >>  ${HOME}/.config/rofi/myrofi.rasi;
}

setup_rofi_main() {
  # TODO: Check if rofi is installed!

  section 'rofi';
  rofi_pre_setup;

  while true; do
    echo "";
    echo "Choose a colorscheme:";
    echo "    n: Nord";
    echo "";

    read -p "Colorscheme? [n]  " cs;
    case $cs in
      [Nn])
        setup_rofi_nord;
        break;;
      *) continue;;
    esac
  done

  while true; do
    echo "";
    echo "dpi:";
    echo "    h: High";
    echo "    l: Low";
    echo "";

    read -p "dpi? [h,l]  " dpi;
    case $dpi in
      [Hh])
        setup_rofi_dpi 256;
        break;;
      [Ll])
        setup_rofi_dpi 96;
        break;;
      *) continue;;
    esac
  done

  rofi_install_numix_icons
  rofi_post_setup
}
