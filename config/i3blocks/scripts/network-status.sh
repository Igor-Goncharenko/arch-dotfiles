#!/bin/bash

INTERFACE=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $5; exit}')
if [ -z "$INTERFACE" ]; then
    echo "❌ No net"
    echo "❌ No net"
    echo "#cc241d"
    exit 0
fi

WIFI_INFO=$(nmcli dev wifi list | grep "^\*")

SSID=$(echo "$WIFI_INFO" | awk '{
    for(i=3;i<=NF;i++) {
        if ($i == "Infra") break
        printf "%s ", $i
    }
}' | sed 's/ *$//')

SIGNAL=$(echo "$WIFI_INFO" | awk '{
    for(i=1;i<=NF;i++) {
        if ($i ~ /^[0-9]+$/ && $(i+1) ~ /[▂▄▆_]/) {
            print $i
            exit
        }
    }
}')

LOCAL_IP=$(ip addr show $INTERFACE | grep -oP 'inet \K[\d.]+' | head -1)
GLOBAL_IP=$(curl -s ifconfig.me)

echo "$SSID[$SIGNAL%] $GLOBAL_IP $LOCAL_IP"
echo "$SSID[$SIGNAL%] $GLOBAL_IP $LOCAL_IP"
echo "#ebdbb2"
