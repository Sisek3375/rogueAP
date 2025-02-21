#!/bin/bash

echo "[+] Configuration du réseau..."
ip addr add 192.168.1.1/24 dev wlan1
ip link set wlan1 up

echo "[+] Activation du routage et du NAT..."
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -F
iptables -X
iptables -Z
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

echo "[+] Démarrage des services..."
hostapd AP_OPEN &
dnsmasq -d -C dnsmasq.conf &
nodogsplash
