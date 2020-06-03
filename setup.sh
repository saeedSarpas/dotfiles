#!/usr/bin/env bash
source ./vim/setup_vim.sh

main() {

  echo "Saeed's setup script!"
  echo ""
  echo "Please use one of the following actions:"
  echo "    v: vim"
  echo "    q: quit"
  echo ""

  while true; do
    read -p 'Action? [v,q] ' action
    case $action in
      [Vv]) setup_vim_main;;
      [Qq]) exit;;
      *) continue;;
    esac
  done
}

main $@
