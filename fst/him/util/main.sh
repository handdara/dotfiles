#!/bin/sh
HIM_DIR=$(dirname $(dirname "$(realpath "$0")"))
MAIN_DIR="$HIM_DIR/nvim-main"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
# Clear previous
rm -Rf "$NVIM_CONFIG_DIR"
# mk config symlink
ln -sv "$MAIN_DIR" "$NVIM_CONFIG_DIR"
