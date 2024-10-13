#!/bin/sh
HIM_DIR=$(dirname $(dirname "$(realpath "$0")"))
MAIN_DIR="$HIM_DIR/wezterm-main"
WEZ_CONFIG_DIR="$HOME/.config/wezterm"
# Clear previous
rm -Rf "$WEZ_CONFIG_DIR"
# mk config symlink
ln -sv "$MAIN_DIR" "$WEZ_CONFIG_DIR"
