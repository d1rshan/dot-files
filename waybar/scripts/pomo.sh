#!/usr/bin/env bash

STATE_FILE=/tmp/pomo_state

case "$1" in
start)
  duration=$((20 * 60))
  end_time=$(($(date +%s) + duration))
  echo "$end_time" >"$STATE_FILE"
  notify-send "Pomodoro" "Focus session started (20 minutes)"
  exit 0
  ;;

stop)
  rm -f "$STATE_FILE"
  notify-send "Pomodoro" "Timer stopped"
  exit 0
  ;;

toggle)
  if [ -f "$STATE_FILE" ]; then
    rm -f "$STATE_FILE"
    notify-send "Pomodoro" "Timer canceled"
  else
    duration=$((20 * 60))
    end_time=$(($(date +%s) + duration))
    echo "$end_time" >"$STATE_FILE"
    notify-send "Pomodoro" "Focus started — 20 minutes"
  fi
  exit 0
  ;;
esac

# Default/tick output when clicking not running commands
if [ ! -f "$STATE_FILE" ]; then
  echo '{"text":"00:00"}'
  exit 0
fi

end_time=$(cat "$STATE_FILE")
now=$(date +%s)
remaining=$((end_time - now))

# Timer finished
if [ $remaining -le 0 ]; then
  rm -f "$STATE_FILE"
  notify-send "Pomodoro Complete 🎉" "Time to take a break!"
  echo '{"text":"✅ Done"}'
  exit 0
fi

min=$((remaining / 60))
sec=$((remaining % 60))
printf '{"text":"%02d:%02d"}\n' "$min" "$sec"
