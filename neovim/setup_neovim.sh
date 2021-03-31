#!/usr/bin/env bash

neovimdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source ${neovimdir}/../helpers/logging.sh
source ${neovimdir}/../helpers/mycommands.sh

setup_neovim_directories() {
  if [ -d ${HOME}/.config/nvim ];then
    log 'Pulling the latest changes from master branch'
    cd ${HOME}/.config/nvim && git pull origin master 2>&1 | log_stdout
  else
    log 'Cloning init.vim repository'
    cd ${HOME}/.config && git clone https://gitlab.com/saeedSarpas/init.vim.git 2>&1 | log_stdout
  fi
}

setup_neovim_main() {
  section 'Neovim'
  setup_neovim_directories

  log "Installing the plugins";
  nvim --headless +PlugInstall +qa;
}


