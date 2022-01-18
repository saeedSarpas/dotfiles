#!/usr/bin/env bash
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${HOME}/.zaliases.d/utils.sh;

# :J - java
fnction _java_help() {
  local _command=$(fuzzy_select echo "${_java_options}" | awk '{$1=""; print $0}');

  to_term_buffer ${_command};
}

read -r -d '' _java_options << EOM
:JGc  ./gradlew clean --warning-mode all
:JGcd ./gradlew clean --refresh-dependencies --warning-mode all
:JGtu Update gradle :tasks
:JGt  Selects a gradle task
EOM

alias :J=_java_help;

alias :JGc='./gradlew clean --warning-mode all'
alias :JGcd='./gradlew clean --refresh-dependencies --warning-mode all'
alias :JGtu='_java_update_gradle_tasks'
alias :JGt='_java_gradle_tasks'

function _java_gradle_tasks_fname() {
  echo "${HOME}/.tmp/gradle_$(sed 's/\//_/g' <<< $(pwd)).txt"
}

function _java_update_gradle_tasks() {
  local gradle_tasks_file=$(_java_gradle_tasks_fname);
  gradle tasks --all > ${gradle_tasks_file}
}

function _java_gradle_tasks() {
  local gradle_tasks_file=$(_java_gradle_tasks_fname);

  if [ ! -f "$gradle_tasks_file" ]; then
    _java_update_gradle_tasks
  fi

  local _task=$(fuzzy_select cat ${gradle_tasks_file} | awk '{print $1}');
  if [ -n "${_task}" ]; then
    to_term_buffer "./gradlew ${_task}";
  fi
}
