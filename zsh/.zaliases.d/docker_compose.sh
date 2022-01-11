#!/usr/bin/env bash
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${HOME}/.zaliases.d/utils.sh;

# :D - docker-compose

function _docker_compose_help() {
  local _command=$(fuzzy_select echo "${_docker_compose_options} | awk '{$1=""; print $0}'");

  to_term_buffer ${_command};
}

read -r -d '' _docker_compose_options << EOM
:DCf   docker-compose -f
:DCfu  docker-compose -f <Dockerfile> up
:DCfd  docker-compose -f <Dockerfile> down
:DCfl  docker-compose -f <Dockerfile> logs
:DCp   docker-compose ps
:DCu docker-compose up
:DCd docker-compose down
:DCl docker-compose logs
EOM

alias :DC=_docker_compose_help;
alias :DCf=_docker_compose_file
alias :DCfu=_docker_compose_file_up
alias :DCfd=_docker_compose_file_down
alias :DCfl=_docker_compose_file_logs
alias :DCp='docker-compose ps'
alias :DCu='docker-compose up'
alias :DCd='docker-compose down'
alias :DCl='docker-compose logs'


function _docker_compose_file() {
  to_term_buffer "docker-compose -f $(_choose_file)";
}

function _docker_compose_file_up() {
  to_term_buffer "docker-compose -f $(_choose_file) up";
}

function _docker_compose_file_down() {
  to_term_buffer "docker-compose -f $(_choose_file) down";
}

function _docker_compose_file_logs() {
  to_term_buffer "docker-compose -f $(_choose_file) logs";
}
