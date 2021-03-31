#!/usr/bin/env bash
source ./i3/setup_i3.sh
source ./picom/setup_picom.sh
source ./rofi/setup_rofi.sh
source ./termite/setup_termite.sh
source ./vim/setup_vim.sh
source ./zsh/setup_zsh.sh

main() {
  while true; do
    echo "Saeed's setup script!"
    echo ""
    echo "Please use one of the following actions:"
    echo "    i: i3"
    echo "    p: picom"
    echo "    r: rofi"
    echo "    t: termite"
    echo "    v: vim"
    echo "    z: zsh"
    echo "    q: quit"
    echo ""

    read -p 'Action? [i,p,r,t,v,z,q] ' action
    case $action in
      [Ii]) setup_i3_main;;
      [Pp]) setup_picom_main;;
      [Rr]) setup_rofi_main;;
      [Tt]) setup_termite_main;;
      [Vv]) setup_vim_main;;
      [Zz]) setup_zsh_main;;
      [Qq]) exit;;
      *) continue;;
    esac
  done
}

main $@
