#!/bin/bash

# Configure each DP output to be above the laptop
setup_outputs(){
  for output in $(swaymsg -t get_outputs | jq -r '.[].name'); do
    if [[ $output == DP-* ]] || [[ $output == HDMI-* ]]; then
      swaymsg "output $output pos 0 0 res 1920x1080"
    fi
  done
}

setup_outputs

COOLDOWN=3
LAST_RUN=0

swaymsg -m -t subscribe '["output"]' | jq --unbuffered -r '.change' | while read -r event; do
  if [ "$event" = "unspecified" ]; then
    CURRENT_TIME=$(date +%s)
    TIME_DIFF=$((CURRENT_TIME - LAST_RUN))
    if [[ $TIME_DIFF -ge $COOLDOWN ]]; then
      LAST_RUN=$CURRENT_TIME
      setup_outputs
    fi
  fi
done
