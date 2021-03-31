#!/usr/bin/env bash
source ./gtk/setup_gtk.sh
source ./i3/setup_i3.sh
source ./neovim/setup_neovim.sh
source ./picom/setup_picom.sh
source ./polybar/setup_polybar.sh
source ./rofi/setup_rofi.sh
source ./termite/setup_termite.sh
source ./vim/setup_vim.sh
source ./X11/setup_x11.sh
source ./zsh/setup_zsh.sh

main() {
  while true; do
    echo "Saeed's setup script!"
    echo ""
    echo "Please use one of the following actions:"
    echo "    b: polybar"
    echo "    g: GTK2/3"
    echo "    i: i3"
    echo "    n: neovim"
    echo "    p: picom"
    echo "    r: rofi"
    echo "    t: termite"
    echo "    v: vim"
    echo "    x: X11"
    echo "    z: zsh"
    echo "    q: quit"
    echo ""

    read -p 'Action? [b,i,p,r,t,v,x,z,q] ' action
    case $action in
      [Bb]) setup_polybar_main;;
      [Ii]) setup_i3_main;;
      [Gg]) setup_gtk_main;;
      [Nn]) setup_neovim_main;;
      [Pp]) setup_picom_main;;
      [Rr]) setup_rofi_main;;
      [Tt]) setup_termite_main;;
      [Vv]) setup_vim_main;;
      [Xx]) setup_x11_main;;
      [Zz]) setup_zsh_main;;
      [Qq]) exit;;
      *) continue;;
    esac
  done
}

main $@
