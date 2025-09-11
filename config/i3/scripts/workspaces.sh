#!/bin/bash

MONITOR_PRIMARY="eDP-1"
MONITOR_SECONDARY="HDMI-1"

WORKSPACES=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

SPLIT_POINT=5

case $1 in
    --primary-edp|--default)
        #i3-msg "workspace \"__no_workspaces__\"; move workspace to output $MONITOR_SECONDARY" > /dev/null
        for ws in "${WORKSPACES[@]}"; do
            i3-msg "workspace \"$ws\"; move workspace to output $MONITOR_PRIMARY" > /dev/null
        done
        ;;

    --primary-hdmi)
        #i3-msg "workspace \"__no_workspaces__\"; move workspace to output $MONITOR_PRIMARY" > /dev/null
        for ws in "${WORKSPACES[@]}"; do
            i3-msg "workspace \"$ws\"; move workspace to output $MONITOR_SECONDARY" > /dev/null
        done
        ;;

    --split-hdmi-primary)
        for i in "${!WORKSPACES[@]}"; do
            if [ $i -lt $SPLIT_POINT ]; then
                i3-msg "workspace \"${WORKSPACES[i]}\"; move workspace to output $MONITOR_SECONDARY" > /dev/null
            else
                i3-msg "workspace \"${WORKSPACES[i]}\"; move workspace to output $MONITOR_PRIMARY" > /dev/null
            fi
        done
        ;;

    --split-edb-primary)
        for i in "${!WORKSPACES[@]}"; do
            if [ $i -lt $SPLIT_POINT ]; then
                i3-msg "workspace \"${WORKSPACES[i]}\"; move workspace to output $MONITOR_PRIMARY" > /dev/null
            else
                i3-msg "workspace \"${WORKSPACES[i]}\"; move workspace to output $MONITOR_SECONDARY" > /dev/null
            fi
        done
        ;;

    *)
        ;;
esac
