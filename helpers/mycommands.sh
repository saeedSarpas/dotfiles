#!/usr/bin/env bash

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source ${here}/logging.sh

myln() {
  log "$1 -> $2"
  ln -s $1 $2
}
