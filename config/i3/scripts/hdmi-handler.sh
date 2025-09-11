#!/bin/bash

OUTPUT=HDMI-1

sleep 2

current_state=""

get_max_resolution() {
    xrandr | grep -A1 "$OUTPUT connected" | grep -E "[0-9]+x[0-9]+" | \
    sort -nr -k1 | head -1 | awk '{print $1}'
}

handle_hdmi() {
    if xrandr | grep -q "$OUTPUT connected"; then
        # HDMI connected
        if [ "$current_state" != "connected" ]; then
            echo "$(date): $OUTPUT connected"
            RESOLUTION=$(get_max_resolution)
            if [ -n "$RESOLUTION" ]; then
                xrandr --output $OUTPUT --mode "$RESOLUTION" --right-of eDP-1
                echo "For $OUTPUT set resolution: $RESOLUTION"
            else
                xrandr --output $OUTPUT --auto --right-of eDP-1
            fi
            current_state="connected"
        fi
    else
        # HDMI disconnected
        if [ "$current_state" != "disconnected" ]; then
            echo "$(date): $OUTPUT disconnected"
            xrandr --output $OUTPUT --off
            current_state="disconnected"
        fi
    fi
}

echo "Start hdmi monitoring..."
while true; do
    handle_hdmi
    sleep 10
done
