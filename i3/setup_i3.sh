#!/usr/bin/env bash

i3dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${i3dir}/../helpers/logging.sh;
source ${i3dir}/../helpers/mycommands.sh;

i3_pre_setup() {
  safe_clean "${HOME}/.i3";
  safe_mkdir "${HOME}/.config/i3"
  safe_clean "${HOME}/.config/i3/config";
  myTouch "${HOME}/.config/i3/config";
	myAppend ${i3dir}/i3-main.config ${HOME}/.config/i3/config;
}

setup_i3_nord() {
	myAppend ${i3dir}/i3-nord-colors.config ${HOME}/.config/i3/config;
}

setup_i3_bar() {
	myAppend ${i3dir}/i3-bar.config ${HOME}/.config/i3/config;
}

setup_kde_bar() {
  safe_mkdir "${HOME}/.config/plasma-workspace/env";
  myCp "${i3dir}/set_window_manager.sh" "${HOME}/.config/plasma-workspace/env/set_window_manager.sh"
  chmod +x ${HOME}/.config/plasma-workspace/env/set_window_manager.sh;

	myAppend ${i3dir}/i3-kde.config ${HOME}/.config/i3/config;
}

setup_i3_polybar() {
  safe_mkdir "${HOME}/.config/polybar";
  safe_clean "${HOME}/.config/polybar/config.ini";

  myCp "${i3dir}/../polybar/polybar.config" "${HOME}/.config/polybar/config.ini";
  myCp "${i3dir}/../polybar/polybar-launch.sh" "${HOME}/.config/polybar/launch.sh";
	chmod +x ${HOME}/.config/polybar/launch.sh;

	myAppend ${i3dir}/i3-polybar.config ${HOME}/.config/i3/config;
}

i3_post_setup() {
  myCp "${i3dir}/../imgs/desktop-bg.jpg" "${HOME}/.config/i3/";
  myCp "${i3dir}/i3lock.sh" "${HOME}/.i3lock.sh";
}

setup_i3_main() {
  # TODO: Check if i3 is installed!

  section 'i3wm';
  i3_pre_setup;

  while true; do
    echo "";
    echo "Choose a colorscheme:";
    echo "    n: Nord";
    echo "";

    read -p "Colorscheme? [n]  " cs;
    case $cs in
      [Nn])
        setup_i3_nord;
        break;;
      *) continue;;
    esac
  done

  while true; do
    echo "";
    echo "Choose a bar:";
    echo "    i: i3 bar";
    echo "    k: KDE";
    echo "    p: polybar";
    echo "";

    read -p "Bar? [i,k,p] " bar;
    case $bar in
      [Ii])
        setup_i3_bar;
        break;;
      [Kk])
        setup_kde_bar;
        break;;
      [Pp])
        setup_i3_polybar;
        break;;
      *) continue;;
    esac
  done

  i3_post_setup;

  log 'Restarting i3';
  i3-msg reload;
}

