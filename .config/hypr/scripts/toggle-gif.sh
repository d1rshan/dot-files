#!/bin/sh
# ─────────────────────────────────────────────────────────────────────
#  「✦ GIF OVERLAY TOGGLE ✦ 」
# ─────────────────────────────────────────────────────────────────────
# TOGGLES A FUN GIF OVERLAY ON SCREEN
# ─────────────────────────────────────────────────────────────────────

if pgrep -f "fun_overlay/main.py" >/dev/null; then
  pkill -f "fun_overlay/main.py"
else
  python3 "$HOME/fun_overlay/main.py" "$HOME/fun_overlay/your_gif.gif"
fi
