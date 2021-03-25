#!/usr/bin/env bash
source ./vim/setup_vim.sh
source ./i3/setup_i3.sh
source ./rofi/setup_rofi.sh

main() {
  while true; do
    echo "Saeed's setup script!"
    echo ""
    echo "Please use one of the following actions:"
    echo "    v: vim"
    echo "    i: i3"
    echo "    r: rofi"
    echo "    q: quit"
    echo ""

    read -p 'Action? [v,i,r,q] ' action
    case $action in
      [Vv]) setup_vim_main;;
      [Ii]) setup_i3_main;;
      [Rr]) setup_rofi_main;;
      [Qq]) exit;;
      *) continue;;
    esac
  done
}

main $@
