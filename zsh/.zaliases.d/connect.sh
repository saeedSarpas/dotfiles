#!/usr/bin/env bash
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${HOME}/.zaliases.d/utils.sh;

# :c - connect
fnction _connect_help() {
  local _command=$(fuzzy_select echo "${_connect_options}");

  to_term_buffer ${_command};
}

read -r -d '' _connect_options << EOM
ssh -XY sarpass@theia.ethz.ch
ssh -XY sarpass@eos.ethz.ch
ssh -XY sarpass@hyperion.ethz.ch
ssh -XY sarpass@selene.ethz.ch
ssh -XY sarpass@phoebe.ethz.ch
ssh -XY sarpass@login.phys.ethz.ch
ssh -XY sarpass@euler.ethz.ch
ssh -p1234 -XY saeed@gate4.astro.uni-bonn.de
ssh -XY saeed@hobbes
EOM

alias :c=_connect_help;
