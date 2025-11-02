#!/usr/local/env bash

nm-applet --indicator &
hypridle & 
waybar -c /home/main/.config/hypr/waybar-conf.json -s /home/main/.config/hypr/waybar.css & 
hyprpaper &
dunst

