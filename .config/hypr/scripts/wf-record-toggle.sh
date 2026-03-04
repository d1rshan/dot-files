#!/bin/bash

PID=$(pgrep wf-recorder)

if [ -n "$PID" ]; then
  pkill wf-recorder
  notify-send "Recording stopped"
  exit 0
fi

GEOM=$(slurp) || exit 1

[ -z "$GEOM" ] && exit 0

FILE="$HOME/Videos/recording-$(date +%F_%H-%M-%S).mp4"
wf-recorder -g "$GEOM" -f "$FILE" &
# notify-send "Recording started"
