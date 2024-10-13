#!/bin/sh
HISH_DIR=$(dirname $(dirname "$(realpath "$0")"))
MAIN_DIR="$HISH_DIR/fish-main"
FISH_CONFIG_DIR="$HOME/.config/fish"
# Clear previous
rm -Rf "$FISH_CONFIG_DIR"
# mk config symlink
ln -sv "$MAIN_DIR" "$FISH_CONFIG_DIR"
