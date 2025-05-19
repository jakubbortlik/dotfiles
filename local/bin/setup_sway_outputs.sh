#!/bin/bash

# Configure each DP output to be above the laptop
for output in $(swaymsg -t get_outputs | jq -r '.[].name'); do
  if [[ $output == DP-* ]] || [[ $output == HDMI-* ]]; then
    swaymsg "output $output pos 0 0 res 1920x1080"
  fi
done
