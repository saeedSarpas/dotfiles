#!/usr/bin/env bash
source ./vim/setup_vim.sh
source ./i3/setup_i3.sh
source ./rofi/setup_rofi.sh
source ./picom/setup_picom.sh
source ./termite/setup_termite.sh

main() {
  while true; do
    echo "Saeed's setup script!"
    echo ""
    echo "Please use one of the following actions:"
    echo "    v: vim"
    echo "    i: i3"
    echo "    r: rofi"
    echo "    p: picom"
    echo "    t: termite"
    echo "    q: quit"
    echo ""

    read -p 'Action? [v,i,r,p,q] ' action
    case $action in
      [Vv]) setup_vim_main;;
      [Ii]) setup_i3_main;;
      [Rr]) setup_rofi_main;;
      [Pp]) setup_picom_main;;
      [Tt]) setup_termite_main;;
      [Qq]) exit;;
      *) continue;;
    esac
  done
}

main $@
