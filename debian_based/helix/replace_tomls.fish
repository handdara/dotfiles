

if set -q WSL_DISTRO_NAME[1]
  echo "Writing wsl version"
  cp ./wsl2/*.toml ~/.config/helix/
else
  echo "Writing native ubuntu versions"
  cp ./*.toml ~/.config/helix/
end
