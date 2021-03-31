#!/usr/bin/env bash

mycommandshere="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source ${mycommandshere}/logging.sh

myln() {
  if [ ! -n "$1" ]; then log "myLn needs exactly two arguments"; return; fi
  if [ ! -n "$2" ]; then log "myLn needs exactly two arguments"; return; fi

  log "link $1 -> $2";
  ln -s $2 $1;
}

myCp() {
  if [ ! -n "$1" ]; then log "myMv needs exactly two arguments"; return; fi
  if [ ! -n "$2" ]; then log "myMv needs exactly two arguments"; return; fi

  log "cp $1 -> $2";
  cp $1 $2;
}

myRm() {
  if [ ! -n "$1" ]; then log "myRm needs exactly one argument"; return; fi

  log "delete $1";
  rm $1;
}

myBkp() {
  if [ ! -n "$1" ]; then log "myRm needs exactly one argument"; return; fi

  log "backup $1 -> $1.bkp";
  cp $1 $1.bkp;
}

myMv() {
  if [ ! -n "$1" ]; then log "myMv needs exactly two arguments"; return; fi
  if [ ! -n "$2" ]; then log "myMv needs exactly two arguments"; return; fi

  log "move $1 -> $2";
  mv $1 $2;
}

myTouch() {
  if [ ! -n "$1" ]; then log "myTouch needs exactly two arguments"; return; fi

  log "touch $1";
  touch $1;
}

myAppend() {
  if [ ! -n "$1" ]; then log "myAppend needs exactly two arguments"; return; fi
  if [ ! -n "$2" ]; then log "myAppend needs exactly two arguments"; return; fi

  log "append $1 >> $2";
  cat $1 >> $2;
}

myMkdir() {
  if [ ! -n "$1" ]; then log "myMkdir needs exactly two arguments"; return; fi

  log "mkdir $1"
  mkdir -p $1;
}

safe_mkdir() {
  if [ ! -n "$1" ]; then log "safe_clean_direcotry needs exactly one argument"; return; fi

  if [ ! -d $1 ]; then
    myMkdir $1;
  fi
}


safe_clean() {
  if [ ! -n "$1" ]; then log "safe_clean_direcotry needs exactly one argument"; return; fi

  if [ -L $1 ]; then
    myRm $1
  elif [ -f $1 ] || [ -d  $1 ]; then
    myBkp $1;
    myRm $1;
  fi
}
