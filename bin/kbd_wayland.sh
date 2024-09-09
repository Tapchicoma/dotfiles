#!/bin/bash

xremap_bin=/usr/bin/xremap
xremap_config=~/.xremap_config.yml

if ! test -f "$xremap_bin"; then
    echo "Please install gui-apps/xremap"
    exit 1
fi

if ! test -f "$xremap_config"; then
    echo "Xremap config file is not available in $xremap_config, check that it exists."
fi

$xremap_bin $xremap_config 2>&1 &
