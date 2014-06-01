#!/bin/bash

status=$( amixer sget Capture | grep '\[0%\]' )

if [ "$status" = "" ]; then
    amixer sset Capture 0
else
    amixer sset Capture 50
fi
