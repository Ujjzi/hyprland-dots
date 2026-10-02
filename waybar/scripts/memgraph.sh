#!/bin/bash
# ~/.config/waybar/scripts/memgraph.sh
# Draws a 8-bar mini graph of RAM usage history using block chars

BAR_CHARS=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")
HISTORY_FILE="/tmp/waybar_mem_history"
MAX_BARS=8

# Get current memory usage %
MEM=$(free | awk '/^Mem:/ {printf "%.0f", $3/$2 * 100}')
[ -z "$MEM" ] && MEM=0

# Load history
if [ -f "$HISTORY_FILE" ]; then
    mapfile -t HISTORY < "$HISTORY_FILE"
else
    HISTORY=()
fi

# Append and trim
HISTORY+=("$MEM")
if [ ${#HISTORY[@]} -gt $MAX_BARS ]; then
    HISTORY=("${HISTORY[@]: -$MAX_BARS}")
fi

# Save
printf '%s\n' "${HISTORY[@]}" > "$HISTORY_FILE"

# Build graph
GRAPH=""
for VAL in "${HISTORY[@]}"; do
    IDX=$(( VAL * 7 / 100 ))
    [ $IDX -gt 7 ] && IDX=7
    [ $IDX -lt 0 ] && IDX=0
    GRAPH+="${BAR_CHARS[$IDX]}"
done

while [ ${#HISTORY[@]} -lt $MAX_BARS ]; do
    GRAPH="▁$GRAPH"
    HISTORY=("0" "${HISTORY[@]}")
done

echo "$GRAPH"
