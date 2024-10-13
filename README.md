# handdara's dotfiles

`hix`: NixOS config

`fst`: first layer: core tools that have their own config repo. right now this is: neovim, wezterm & fish
    - `git`: git config
    - `hez`: wezterm config
    - `him`: neovim config
    - `hish`: fish config

`snd`: secondary layer: tools that don't fit into core. their dotfiles are here
    - the `gitui` command is not in current use, so it's justfile has an empty default
