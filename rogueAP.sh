#!/bin/bash

# Stop les serices si ils sont lancés
systemctl stop hostapd dnsmasq

# Modifie l'IP de ma carte wifi externe
ip addr add 192.168.1.1/24 dev wlan1

# redirige les données sur internet
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -I POSTROUTING -t nat -o wlan0 -j MASQUERADE

# Ouvrir le premier terminal et exécuter hostapd
hostapd AP_OPEN &

# Ouvrir le deuxième terminal et exécuter dnsmasq
dnsmasq -d -C dnsmasq.conf &

