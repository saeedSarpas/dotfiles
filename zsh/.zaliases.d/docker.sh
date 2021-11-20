#!/usr/bin/env bash
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${HOME}/.zaliases.d/utils.sh;

# :D - docker

function _docker_help() {
  local _command=$(fuzzy_select echo "${_docker_options} | awk '{$1=""; print $0}'");

  to_term_buffer ${_command};
}

read -r -d '' _docker_options << EOM
:Da     docker attach <container>

:Db     docker build -t <tag> .
:Dbf    docker build -t <tag> -f <Dockerfile>

:Dc     docker commit <container> <name:tag>
:Dcc    docker commit --change=<change> <container> <name:tag>

:Dd     docker rm <container>
:Dda    docker rm -f \$(docker ps -a -q)
:Ddi    docker rmi <image>
:Ddia   docker rmi -f \$(docker images -a -q)

:Dps    docker ps
:Dpsa   docker ps -a

:Di     docker images

:Dpull  docker pull <image>

:Drun   docker run <image>
:Druni  docker run -it <image>
:Drund  docker run -d <image>
:Drunid docker run -it -d <image>
:-      docker run -it -d --restart unless-stopped <image>

:Ds     docker search <term>

:Dstop  docker stop <container>
EOM

alias :D=_docker_help;
alias :Da=_docker_attach;
alias :Db='docker build -t <name:tag> .';
alias :Dbf='docker build -t <name:tag> -f <Dockerfile>';
alias :Dc=_docker_commit;
alias :Dcc=_docker_commit_change;
alias :Dd=_docker_delete;
alias :Dda='docker rm -f $(docker ps -a -q)';
alias :Ddi=_docker_delete_image;
alias :Ddia='docker rmi -f $(docker images -a -q)';
alias :Dps='docker ps';
alias :Dpsa='docker ps -a';
alias :Di='docker images';
alias :Dpull=_docker_pull;
alias :Drun=_docker_run;
alias :Druni='_docker_run "bash"';
alias :Drund='_docker_run "daemon"';
alias :Drunid='_docker_run "interactive-daemon"';
alias :Ds=_docker_search;
alias :Dstop=_docker_stop;

function _docker_attach() {
  local _container=$(fuzzy_select docker ps | awk '{print $1}');
  to_term_buffer "docker attach ${_container}";
}

function _docker_commit() {
  local _container=$(fuzzy_select docker ps | awk '{print $1}');
  to_term_buffer "docker commit ${_container}";
}

function _docker_commit_change() {
  local _container=$(fuzzy_select docker ps | awk '{print $1}');
  to_term_buffer "docker commit --change=<change> ${_container}";
}

function _docker_delete() {
  local _container=$(fuzzy_select docker ps -a | awk '{print $1}');
  to_term_buffer "docker rm ${_container}";
}

function _docker_delete_image() {
  local _image=$(fuzzy_select docker images | awk '{print $1}');
  to_term_buffer "docker rmi ${_image}";
}

function _docker_search() {
  local usage='usage: _docker_search before term [args]';
  if [[ -n "$1" ]]; then local _before="$1"; else echo $usage; return; fi
  if [[ -n "$2" ]]; then local term="$2"; else echo $usage; return; fi
  shift 1;

  local _docker_image=$(fuzzy_select docker search $@ | awk '{print $1}');
  to_term_buffer "${_before} ${_docker_image}";
}

function _docker_pull() {
  _docker_search "docker pull" $@
}

function _docker_run() {
  local usage='usage: _docker_run [mode]';
  local _image=$(fuzzy_select docker images | awk '{print $1}');

  if [[ -n "$1" ]]; then
    local _mode="$1";

    case "${_mode}" in
      "bash") to_term_buffer "docker run -it ${_image}";;
      "daemon") to_term_buffer "docker run -d ${_image}";;
      "interactive-daemon") to_term_buffer "docker run -it -d ${_image}";;
      *) continue;;
    esac
  else
    to_term_buffer "docker run ${_image}";
  fi
}

function _docker_stop() {
  local _container=$(fuzzy_select docker ps | awk '{print $1}');
  to_term_buffer "docker stop ${_container}";
}
