#!/usr/bin/env bash
source ./bluetooth/setup_bluetooth.sh
source ./gtk/setup_gtk.sh
source ./i3/setup_i3.sh
source ./grub/setup_grub.sh
source ./mpv/setup_mpv.sh
source ./neovim/setup_neovim.sh
source ./picom/setup_picom.sh
source ./polybar/setup_polybar.sh
source ./rofi/setup_rofi.sh
source ./screen/setup_screen.sh
source ./termite/setup_termite.sh
source ./vim/setup_vim.sh
source ./X11/setup_x11.sh
source ./zsh/setup_zsh.sh

main() {
  while true; do
    echo "Saeed's setup script!"
    echo ""
    echo "Please use one of the following actions:"
    echo "    b: bluetooth"
    echo "    g: GTK2/3"
    echo "    i: i3"
    echo "    n: neovim"
    echo "    m: mpv"
    echo "    o: polybar"
    echo "    p: picom"
    echo "    r: rofi"
    echo "    s: screen"
    echo "    t: termite"
    echo "    u: grub"
    echo "    v: vim"
    echo "    x: X11"
    echo "    z: zsh"
    echo "    q: quit"
    echo ""

    read -p 'Action? [b,g,i,m,n,o,p,r,s,t,u,v,x,z,q] ' action
    case $action in
      [Bb]) setup_bluetooth_main;;
      [Ii]) setup_i3_main;;
      [Gg]) setup_gtk_main;;
      [Mm]) setup_mpv_main;;
      [Nn]) setup_neovim_main;;
      [Oo]) setup_polybar_main;;
      [Pp]) setup_picom_main;;
      [Rr]) setup_rofi_main;;
      [Ss]) setup_screen_main;;
      [Tt]) setup_termite_main;;
      [Uu]) setup_grub_main;;
      [Vv]) setup_vim_main;;
      [Xx]) setup_x11_main;;
      [Zz]) setup_zsh_main;;
      [Qq]) exit;;
      *) continue;;
    esac
  done
}

main $@
