#!/bin/bash

# This script is called by Rofi in two ways:
# 1. With no arguments: It must print a list of "commands".
# 2. With an argument: It means a command was selected.

if [ -z "$@" ]; then
  # 1. No arguments: Print the list of commands
  echo ":wall"
  # echo ":clipboard"  # You can add this later
else
  # 2. Argument given: An item was selected.
  #    Handle the selected command.
  case "$@" in
  ":wall")
    # Run your wallpaper script
    ~/.config/rofi/wallpaper.sh
    ;;
    # ":clipboard")
    # Run your clipboard script
    # ...
    # ;;
  esac
fi
