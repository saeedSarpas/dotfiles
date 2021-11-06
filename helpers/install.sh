#!/usr/bin/env bash

mycommandshere="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source ${mycommandshere}/logging.sh

install() {
  if [[ -n "$1" ]]; then local _arch="$1"; else log "install needs exactly three arguments"; return; fi
  if [[ -n "$2" ]]; then local _ubun="$2"; else log "install needs exactly three arguments"; return; fi
  if [[ -n "$3" ]]; then local _brew="$3"; else log "install needs exactly three arguments"; return; fi

  section "Install a new package"

  local _unameOut="$(uname -s)"
  case "${_unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          err "Unknown OS! (${_unameOut})"; return;;
  esac

  case $machine in
    "Linux")    _linux_install $_arch $_ubun;;
    "Mac")      _brew_install $_brew;;
  esac
}

function _apt_install() {
  if [[ -n "$1" ]]; then local _ubun="$1"; else log "install needs exactly one arguments"; return; fi

  if command -v ${_ubun} &> /dev/null; then
    log "${_ubun} is already installed";
    return
  fi

  if [ "${_ubun}" = "_" ]; then
    err "I skip installation as you have not proveded me with a package name!";
    return
  fi

  log "sudo apt-get install ${_ubun}";
  sudo apt-get install ${_ubun} 2>&1 | log_stdout;
  exec_status $?;
}

function _install_yay() {
  log "Installing yay";
  cd /opt;
  sudo git clone https://aur.archlinux.org/yay-git.git;
  sudo chown -R $(whoami):$(whoami) ./yay-git;
  cd yay-git;
  makepkg -si;
}

function _yay_install() {
  if [[ -n "$1" ]]; then local _arch="$1"; else log "install needs exactly one arguments"; return; fi

  if command -v ${_arch} &> /dev/null; then
    log "${_arch} is already installed";
    return
  fi

  if !command -v yay &> /dev/null; then
    local cwd=$(pwd);
    install_yay;
    local $_status=$?;
    exec_status ${_status};
    cd ${cwd};
  fi

  if [ "${_status}" -eq 0 ]; then
    log "sudo yay install ${_arch}";
    sudo yay -S ${_arch} 2>&1 | log_stdout;
    exec_status $?;
  fi
}

function _linux_install() {
  if [[ -n "$1" ]]; then local _arch="$1"; else err "2 arguments are needed!"; return; fi
  if [[ -n "$2" ]]; then local _ubun="$2"; else err "2 arguments are needed!"; return; fi

  local _distro="$(lsb_release -i | cut -f 2-)"

  case "${_distro}" in
    Arch*)       _yay_install "${_arch}";;
    Ubuntu*)     _apt_install "${_ubun}";;
    *)           log "Unknown distro: ${_distro}"
  esac
}

function _brew_install() {
  if [[ -n "$1" ]]; then local _brew="$1"; else err "1 argument is needed"; return; fi

  if command -v ${_brew} &> /dev/null; then
    log "${_brew} is already installed";
    return
  fi

  if command -v brew &> /dev/null; then
    log "brew install ${_brew}"
    brew install ${_brew} 2>&1 | log_stdout;
    exec_status $?;
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 2>&1 | log_stdout;
    exec_status $?;
  fi
}
