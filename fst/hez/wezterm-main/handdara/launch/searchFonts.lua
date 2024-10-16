return {
    label = 'search through all fonts',
    args = { 'fish', '-c', 'nix-shell -p fontconfig --run "fc-list | fzf"' },
}
