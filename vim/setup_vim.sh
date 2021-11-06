#!/usr/bin/env bash

vimdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source ${vimdir}/../helpers/logging.sh
source ${vimdir}/../helpers/mycommands.sh
source ${vimdir}/../helpers/install.sh


setup_vim_soft_links() {
  safe_mkdir "${HOME}/.vim";
  myCp "${vimdir}/vimrc" "${HOME}/.vimrc";

  curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
}

setup_vim_main() {
  section 'Vim';

  install 'vim' 'vim' 'macvim';

  setup_vim_soft_links;

  log "Installing the plugins";
  vim +'PlugInstall --sync' +qa;
}
