#!/bin/bash

case ${BLOCK_BUTTON:-0} in
    3) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
    4) pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
    5) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
esac

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
IS_MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -qi "yes" && echo "yes" || echo "no")
IS_BLUETOOTH=$(pactl get-default-sink | grep -qi "bluez" && echo "yes" || echo "no")

if [ "$IS_BLUETOOTH" = "yes" ]; then
    NAME="BLUETOOTH"
    SHORT_NAME="B"
    COLOR_ACTIVE="#458588"
    COLOR_MUTED="#83a598"
else
    NAME="SPEAKERS"
    SHORT_NAME="S"
    COLOR_ACTIVE="#ebdbb2"
    COLOR_MUTED="#a89984"
fi

if [ "$IS_MUTED" = "yes" ]; then
    echo "MUTED $VOLUME"
    echo "M $VOLUME"
    echo "$COLOR_MUTED"
else
    echo "$NAME $VOLUME"
    echo "$SHORT_NAME $VOLUME"
    echo "$COLOR_ACTIVE"
fi
