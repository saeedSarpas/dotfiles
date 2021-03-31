#!/usr/bin/env bash

grubdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${grubdir}/../helpers/logging.sh;
source ${grubdir}/../helpers/mycommands.sh;
source ${grubdir}/../colors/nord.sh;

setup_grub_eslimi() {
  log "Making default directories";
  sudo mkdir -p /boot/grub/themes/grub-eslimi-theme;

  log "Cloning grub-eslimi-theme...";
  sudo git clone --recursive https://gitlab.com/saeedSarpas/grub-eslimi-theme.git /boot/grub/themes/grub-eslimi-theme | log_stdout;

  log "Updading theme";
	sudo sed -i "$(grep -n "GRUB_THEME" /etc/default/grub | cut -d ":" -f1)s/.*/GRUB_THEME=/boot/grub/themesgrub-eslimi-theme/theme.txt/" /etc/default/grub | log_stdout;
  grub-mkconfig -o /boot/grub/grub.cfg
}

setup_grub_main() {
  section 'grub';

  while true; do
    echo "";
    echo "Choose a theme:";
    echo "    e: Eslimi";
    echo "";

    read -p "Theme? [e]  " theme;
    case $theme in
      [Ee])
        setup_grub_eslimi;
        break;;
      *) continue;;
    esac
  done
}
