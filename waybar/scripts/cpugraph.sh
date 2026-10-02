#!/bin/bash
# ~/.config/waybar/scripts/cpugraph.sh
# Draws a 8-bar mini graph of CPU usage history using block chars

BAR_CHARS=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")
HISTORY_FILE="/tmp/waybar_cpu_history"
MAX_BARS=8

# Get current CPU usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1 | cut -d',' -f1)
CPU=${CPU%.*}
[ -z "$CPU" ] && CPU=0

# Load history
if [ -f "$HISTORY_FILE" ]; then
    mapfile -t HISTORY < "$HISTORY_FILE"
else
    HISTORY=()
fi

# Append new value and keep last MAX_BARS entries
HISTORY+=("$CPU")
if [ ${#HISTORY[@]} -gt $MAX_BARS ]; then
    HISTORY=("${HISTORY[@]: -$MAX_BARS}")
fi

# Save history
printf '%s\n' "${HISTORY[@]}" > "$HISTORY_FILE"

# Build graph string
GRAPH=""
for VAL in "${HISTORY[@]}"; do
    IDX=$(( VAL * 7 / 100 ))
    [ $IDX -gt 7 ] && IDX=7
    [ $IDX -lt 0 ] && IDX=0
    GRAPH+="${BAR_CHARS[$IDX]}"
done

# Pad to MAX_BARS if history is short
while [ ${#HISTORY[@]} -lt $MAX_BARS ]; do
    GRAPH="▁$GRAPH"
    HISTORY=("0" "${HISTORY[@]}")
done

echo "$GRAPH"
