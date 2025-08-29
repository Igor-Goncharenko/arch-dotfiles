#!/bin/bash

case ${BLOCK_BUTTON:-0} in
    4) brightnessctl set +5% >/dev/null ;;
    5) brightnessctl set 5%- >/dev/null ;;
esac

if command -v brightnessctl &>/dev/null; then
    PERCENTAGE=$(brightnessctl -m | cut -d, -f4 | tr -d '%')
    echo "☀️ $PERCENTAGE%"
    echo "☀️ $PERCENTAGE%"
    echo "#ebdbb2"
fi
