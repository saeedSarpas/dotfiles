#!/usr/bin/env bash

bluetoothdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${bluetoothdir}/../helpers/logging.sh;
source ${bluetoothdir}/../helpers/mycommands.sh;

bluetooth_pre_setup() {
  log "Installing necessary packages";
  sudo pacman -S pulseaudio-alsa pulseaudio-bluetooth bluez bluez-libs bluez-utils blueberr | log_stdout;

  log "Cloning rofi-bluetooth";
  safe_mkdir ${HOME}/.tmp;
  git clone git@github.com:ClydeDroid/rofi-bluetooth.git ${HOME}/.tmp/rofi-bluetooth | log_stdout;

  log "Copy the executable to the local bin directory";
  safe_mkdir ${HOME}/.local/bin;
  cp ${HOME}/.tmp/rofi-bluetooth/rofi-bluetooth ${HOME}/.local/bin/rofi-bluetooth;

  sed -i -e 's/rofi\ -dmenu/\/usr\/bin\/rofi\ -dmenu/g' ${HOME}/.local/bin/rofi-bluetooth
}

bluetooth_i3_setup() {
  log "Updating i3 config";
  safe_string_append "bindsym \$mod+b exec --no-startup-id ${HOME}/.local/bin/rofi-bluetooth" ${HOME}/.config/i3/config;

  log 'Restarting i3';
  i3-msg reload;
}

bluetooth_polybar_setup() {
  log "Updating polybar config";
  sed -i -e 's/network\ battery/network\ bluetooth\ battery/g' ${HOME}/.config/polybar/config;

  log "Restarting polybar";
  killall polybar;
  ${HOME}/.config/polybar/launch.sh &
}

bluetooth_cleanup() {
  myForceRm ${HOME}/.tmp/rofi-bluetooth
}

setup_bluetooth_main() {
  section 'bluetooth';

  bluetooth_pre_setup;
  bluetooth_i3_setup;
  bluetooth_polybar_setup;
  bluetooth_cleanup;
}

