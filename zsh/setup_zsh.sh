#!/usr/bin/env bash

zshdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${zshdir}/../helpers/logging.sh;
source ${zshdir}/../helpers/mycommands.sh;


zsh_setup() {
  myCp "${zshdir}/zshrc" "${HOME}/.zshrc";
  myCp "${zshdir}/zaliases" "${HOME}/.zaliases";
  safe_mkdir "${HOME}/.zaliases.d";
  myCp "${zshdir}/.zaliases.d" "${HOME}";
  myCp "${zshdir}/.zaliases.d/connect.sh" "${HOME}/.zaliases.d/connect.sh";
  myCp "${zshdir}/zshenv" "${HOME}/.zshenv";
  myTouch "${HOME}/.zshrc.local";
  myTouch "${HOME}/.zaliases.local";
  myTouch "${HOME}/.zshenv.local";
}

setup_zsh_main() {
  # TODO: check if zsh is installed

  section 'zsh';
  zsh_setup;

  log "restarting zsh";
  exec zsh -l;
}
