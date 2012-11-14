#!/bin/sh

/usr/bin/jarsigner -verbose -sigalg MD5withRSA -digestalg SHA1 $@
