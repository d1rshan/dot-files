#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────
#  「✦ POMODORO TIMER ✦ 」
# ─────────────────────────────────────────────────────────────────────
# WAYBAR MODULE FOR POMODORO-STYLE BREAK TIMER
# ─────────────────────────────────────────────────────────────────────

STATE_FILE=/tmp/break_state
COOLDOWN_FILE=/tmp/break_cooldown

DURATION=$((20 * 60))
COOLDOWN=20

case "$1" in
start)
  end_time=$(($(date +%s) + DURATION))
  echo "$end_time" >"$STATE_FILE"
  rm -f "$COOLDOWN_FILE"
  notify-send "Break Time" "Session started (20 minutes)"
  exit 0
  ;;

stop)
  rm -f "$STATE_FILE" "$COOLDOWN_FILE"
  notify-send "Break Time" "Timer stopped"
  exit 0
  ;;

toggle)
  if [ -f "$STATE_FILE" ]; then
    rm -f "$STATE_FILE" "$COOLDOWN_FILE"
    notify-send "Break Time" "Timer stopped"
  else
    end_time=$(($(date +%s) + DURATION))
    echo "$end_time" >"$STATE_FILE"
    rm -f "$COOLDOWN_FILE"
    notify-send "Break Time" "Session started (20 minutes)"
  fi
  exit 0
  ;;
esac

if [ ! -f "$STATE_FILE" ]; then
  echo '{"text":"00:00"}'
  exit 0
fi

now=$(date +%s)

if [ -f "$COOLDOWN_FILE" ]; then
  cooldown_end=$(cat "$COOLDOWN_FILE")
  remaining=$((cooldown_end - now))

  if [ $remaining -le 0 ]; then
    end_time=$(($(date +%s) + DURATION))
    echo "$end_time" >"$STATE_FILE"
    rm -f "$COOLDOWN_FILE"
    notify-send "Break Time" "Session restarted"
    remaining=$DURATION
  else
    printf '{"text":"⏳ %02d"}\n' "$remaining"
    exit 0
  fi
fi

end_time=$(cat "$STATE_FILE")
remaining=$((end_time - now))

if [ $remaining -le 0 ]; then
  cooldown_end=$(($(date +%s) + COOLDOWN))
  echo "$cooldown_end" >"$COOLDOWN_FILE"
  notify-send "Break Time" "Session complete — restarting soon"
  echo '{"text":"00:00"}'
  exit 0
fi

min=$((remaining / 60))
sec=$((remaining % 60))
printf '{"text":"%02d:%02d"}\n' "$min" "$sec"
