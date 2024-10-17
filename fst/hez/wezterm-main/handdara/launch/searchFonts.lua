return {
  label = 'search through system fonts',
  args = { 'fish', '-c', 'nix-shell -p fontconfig --run "fc-list | fzf > ~/.local/share/searchFont.out"' }
}
