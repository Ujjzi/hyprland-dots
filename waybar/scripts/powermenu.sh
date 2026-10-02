#!/usr/bin/env bash
# ╔═══════════════════════════════════════════════════════════╗
# ║  powermenu.sh — Rofi power menu with hacker style        ║
# ╚═══════════════════════════════════════════════════════════╝

# Options
shutdown="󰐥  Shutdown"
reboot="󰜉  Reboot"
lock="󰍁  Lock"
suspend="󰒲  Suspend"
hibernate="󰒲  Hibernate"
logout="󰍃  Logout"

# Fuzzel dmenu
chosen=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | \
    fuzzel --dmenu \
           --prompt "  Power  " \
           --lines 5 \
           --width 20)

case "$chosen" in
    *"Shutdown"*)  systemctl poweroff ;;
    *"Reboot"*)    systemctl reboot ;;
    *"Lock"*)      hyprlock ;;
    *"Suspend"*)   systemctl suspend ;;
    *"Hibernate"*) systemctl hibernate ;;
    *"Logout"*)    hyprctl dispatch exit ;;
esac
