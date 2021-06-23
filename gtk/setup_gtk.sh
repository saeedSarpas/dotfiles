#!/usr/bin/env bash

gtkdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${gtkdir}/../helpers/logging.sh;
source ${gtkdir}/../helpers/mycommands.sh;

setup_gtk() {
  safe_mkdir "${HOME}/.config/gtk-3.0/";

  myCp "${gtkdir}/gtkrc-2.0" "${HOME}/.gtkrc-2.0";
  myCp "${gtkdir}/gtkrc-3.0" "${HOME}/.config/gtk-3.0/settings.ini";

  log "[GTK +2] Use oomox-git to generate a theme";
}

setup_qogir_theme() {
  safe_mkdir "${HOME}/.tmp";

  log "Cloning Qogir theme into ${HOME}/.tmp";
  git clone https://github.com/vinceliuice/Qogir-theme.git ${HOME}/.tmp/Qogir;

  cd ${HOME}/.tmp/Qogir && sudo ./install.sh -g -c dark -t standard | log_stdout;

  log "Firefox theme: https://github.com/vinceliuice/Qogir-theme/tree/master/src/firefox"

  myForceRm ${HOME}/.tmp/Qogir;
}

setup_gtk_main() {
  section 'gtk';
  setup_gtk;

  log "Setting windows buttons";
  gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,maximize,close;


  while true; do
    echo "";
    echo "Select a theme:";
    echo "    Q: Qogir";
    echo "    q: quit";
    echo "";

    read -p "Theme? [o,q] " theme;
    case $theme in
      [Q])
        setup_qogir_theme;
        break;;
      [q])
        break;;
      *) continue;;
    esac
  done

  log "Use Themix to generate a new theme";
}
