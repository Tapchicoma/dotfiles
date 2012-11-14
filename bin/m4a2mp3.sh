#!/bin/sh
# name of this script: m4a2mp3.sh
# converts m4a audio files to mp3

for i in *.m4a; do
    faad "$i"
    x=`echo "$i"|sed -e 's/.m4a/.wav/'`
    y=`echo "$i"|sed -e 's/.m4a/.mp3'`
    lame -h -b 320 "$x" "$y"
    rm "$x"
done
