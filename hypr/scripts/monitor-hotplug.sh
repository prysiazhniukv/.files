#!/usr/bin/env bash

SOCK="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# function that applies your monitor policy
apply_policy() {
    if hyprctl monitors -j | jq -r '.[].name' | grep -q "HDMI-A-1"; then
        # HDMI connected → disable laptop
        hyprctl keyword monitor "eDP-1,disable"
    else
        # HDMI disconnected → enable laptop
        hyprctl keyword monitor "eDP-1,preferred,auto,1"
    fi
}

# run once at startup
apply_policy

# subscribe to Hyprland events
socat - UNIX-CONNECT:"$SOCK" | while read -r line; do
    case "$line" in
        monitoradded*|monitorremoved*)
            apply_policy
            ;;
    esac
done

