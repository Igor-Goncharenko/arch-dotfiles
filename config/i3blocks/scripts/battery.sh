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
        echo "#00FF00"
        ;;
    "Full")
        echo "BAT $capacity%"
        echo "BAT $capacity%"
        echo "#00FF00"
        ;;
    "Discharging")
        if [ $capacity -le 20 ]; then
            echo "BAT⚠ $capacity%"
            echo "BAT⚠ $capacity%"
            echo "#FF0000"
        else
            echo "BAT▼ $capacity%"
            echo "BAT▼ $capacity%"

            if [ $capacity -ge 80 ]; then
                echo "#00FF00"
            elif [ $capacity -ge 50 ]; then
                echo "#FFFF00"
            elif [ $capacity -ge 20 ]; then
                echo "#FFA500"
            fi
        fi
        ;;
    *)
        echo "BAT[UNKNOWN] $capacity%"
        echo "BAT[UNKNOWN] $capacity%"
        echo "#FF00FF"
        ;;
esac

exit 0
