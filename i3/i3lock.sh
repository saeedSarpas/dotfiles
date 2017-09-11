#!/bin/bash

file=/tmp/screen.png
file_miff=/tmp/frosted_0.miff
file_mpc=/tmp/frosted_1.mpc

scrot ${file};

convert -quiet "$file" -blur 0x10 +repage "$file_mpc"

ww=`convert $file -format "%[fx:w]" info:`
hh=`convert $file -format "%[fx:h]" info:`

convert -size ${ww}x${hh} xc: +noise Random \
        -virtual-pixel tile \
        -set colorspace RGB -colorspace gray \
        -contrast-stretch 0% ${file_miff}

convert ${file_miff} \
        -channel R -evaluate sine 10 \
        -channel G -evaluate cosine 10 \
        -channel RG -separate ${file_mpc} -insert 0 miff:- | \
    convert - -set colorspace RGB -define compose:args=5x5 \
            -compose displace -composite "$file"

i3lock -u -i ${file}

# rm ${file} ${file_mpc}
