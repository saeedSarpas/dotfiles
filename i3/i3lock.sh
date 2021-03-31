#!/bin/bash

file=/tmp/screen.png
rm -rf ${file}

file_miff=/tmp/frosted_0.miff
file_mpc=/tmp/frosted_1.mpc

scrot -q 100 ${file};

convert $file -scale 1% -sample 10000% $file

i3lock -u -i ${file}
