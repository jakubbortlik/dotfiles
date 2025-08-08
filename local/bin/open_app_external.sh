#!/bin/bash

EXTERNAL_OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.name | test("^(DP|HDMI)-")) | .name' | head -1)

if [ -n "$EXTERNAL_OUTPUT" ]; then
  swaymsg "workspace number $1; move workspace to output $EXTERNAL_OUTPUT; exec $2"
else
  swaymsg "workspace number $1; exec $2"
fi
