#!/usr/bin/env bash
set -euo pipefail

# This script should be called by udev rules on keyboard add/remove actions:
# SUBSYSTEM=="input", ACTION=="add", ENV{ID_VENDOR_ID}=="04d9", ENV{ID_MODEL_ID}=="0192", RUN+="/bin/su - <user> -c '/path/to/kbd_options_udev.sh'"
# SUBSYSTEM=="input", ACTION=="remove", ENV{ID_VENDOR_ID}=="04d9", ENV{ID_MODEL_ID}=="0192", RUN+="/bin/su - <user> -c '/path/to/kbd_options_udev.sh'"

function configure_on_X11 {
   DISPLAY=":0.0"
   XAUTHORITY=$( find /tmp/xauth_* -type f )
   export DISPLAY XAUTHORITY HOME

   if xinput --list | grep -q "USB-HID Keyboard"; then
       echo "Present"
       setxkbmap -option -option grp:caps_toggle
   else
       echo "Not present"
       setxkbmap -option -option ctrl:nocaps,grp:lctrl_toggle
   fi
}

function configure_on_wayland {
    "Run kbd_wayland.sh on user login"
}

sleep 1
if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    configure_on_wayland
else
    configure_on_X11
fi
