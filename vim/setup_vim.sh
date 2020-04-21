#!/usr/bin/env bash

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source ${here}/../helpers/logging.sh
source ${here}/../helpers/mycommands.sh

setup_nvim_directories() {
  mkdir -p ${HOME}/.config

  if [ -d ${HOME}/.config/nvim ];then
    log 'Pulling the latest changes from master branch'
    cd ${HOME}/.config/nvim && git pull origin master 2>&1 | log_stdout
  else
    log 'Cloning init.vim repository'
    cd ${HOME}/.config && git clone https://gitlab.com/saeedSarpas/init.vim.git 2>&1 | log_stdout
  fi
}

setup_vim_soft_links() {
  if [ -L ${HOME}/.vim ]; then
    rm ${HOME}/.vim
  else
    mv ${HOME}/.vim ${HOME}/.vim.bkp
  fi

  if [ -L ${HOME}/.vimrc ]; then
    rm ${HOME}/.vimrc
  else
    mv ${HOME}/.vimrc ${HOME}/.vimrc.bkp
  fi

  log 'Creating myvim directory'
  mkdir -p ${HOME}/.local/share/myvim

  log 'Linking neovim to myvim'
  for t in `ls ${HOME}/.config/nvim`
  do
    rm -f ${HOME}/.local/share/myvim/$t
    myln ${HOME}/.config/nvim/$t ${HOME}/.local/share/myvim/$t
  done

  myln ${HOME}/.local/share/myvim ${HOME}/.vim 
  myln ${HOME}/.config/nvim/init.vim ${HOME}/.vimrc
}

setup_vim_main() {
  section 'Neovim'
  setup_nvim_directories

  section 'Vim'
  setup_vim_soft_links
}
