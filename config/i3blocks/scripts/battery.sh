#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

if [ -z "$capacity" ]; then
    exit 0
fi

case $status in
    "Charging")
        echo "BAT▲ $capacity%"
        echo "BAT▲ $capacity%"
        echo "#98921a"
        ;;
    "Full")
        echo "BAT $capacity%"
        echo "BAT $capacity%"
        echo "#98971a"
        ;;
    "Discharging")
        if [ $capacity -le 20 ]; then
            echo "BAT⚠ $capacity%"
            echo "BAT⚠ $capacity%"
            echo "#cc241d"
        else
            echo "BAT▼ $capacity%"
            echo "BAT▼ $capacity%"

            if [ $capacity -ge 80 ]; then
                echo "#98971a"
            elif [ $capacity -ge 50 ]; then
                echo "#d79921"
            elif [ $capacity -ge 20 ]; then
                echo "#cc241d"
            fi
        fi
        ;;
    *)
        echo "BAT[UNKNOWN] $capacity%"
        echo "BAT[UNKNOWN] $capacity%"
        echo "#ebdbb2"
        ;;
esac

exit 0
