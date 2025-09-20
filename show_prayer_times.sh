#!/bin/bash
exec > /home/virusminus/prayerbar/prayerbar_debug.log 2>&1

echo "Script started at $(date)"

# Send a signal to waybar to refresh the prayerbar module
pkill -SIGRTMIN+9 waybar

echo "Waybar signaled at $(date)"

# Get the prayer times tooltip
echo "Executing prayerbar command at $(date)"
tooltip=$(/home/virusminus/prayerbar/target/release/prayerbar --city Cairo --country Egypt --method 5 --ampm | jq -r .tooltip | sed 's/<[^>]*>//g')
echo "Prayerbar command executed, tooltip extracted at $(date)"
echo "Tooltip content: $tooltip"

# Replace newlines with <br> for HTML interpretation
html_tooltip=$(echo "$tooltip" | sed ':a;N;s/\n/<br>/g;ta')

# Display as a single notification with HTML interpretation
notify-send -u low -t 5000 -h "Prayer Times" "$html_tooltip"

echo "Notification sent at $(date)"

# Send a signal to waybar to refresh the prayerbar module again
pkill -SIGRTMIN+9 waybar