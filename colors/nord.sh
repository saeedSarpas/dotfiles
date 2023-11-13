#!/usr/bin/env bash

norddir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)";
source ${norddir}/../helpers/logging.sh;
source ${norddir}/../helpers/mycommands.sh;

nord_dark0="2e3440"; # (46, 52, 64)
nord_dark1="3b4252"; # (59, 66, 82)
nord_dark2="434c5e"; # (67, 76, 94)
nord_dark3="4c566a"; # (76, 86, 106)
nord_white0="d8dee9"; # (216, 222, 233)
nord_white1="e5e9f0"; # (229, 233, 240)
nord_white2="eceff4"; # (236, 239, 244)
nord_blue0="8fbcbb"; # (143, 188, 187)
nord_blue1="88c0d0"; # (136, 192, 208)
nord_blue2="81a1c1"; # (129, 161, 193)
nord_blue3="5e81ac"; # (94, 129, 172)
nord_red="bf616a"; # (191, 97, 106)
nord_orange="d08770"; # (208, 135, 112)
nord_yellow="ebcb8b"; # (235, 203, 139)
nord_green="a3be8c"; # (163, 190, 140)
nord_purple="b48ead"; # (180, 142, 173)

