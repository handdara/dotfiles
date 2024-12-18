{
    description = "dotfiles dev";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        alejandra.url = "github:kamadorueda/alejandra/main";
        alejandra.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = {
        nixpkgs,
        flake-utils,
        ...
    } @ inputs:
        flake-utils.lib.eachDefaultSystem (
            system: let
                pkgs = nixpkgs.legacyPackages.${system};
                nativeBuildInputs = [inputs.alejandra.defaultPackage.${system}];

                buildInputs = [];
            in {
                devShells.default = pkgs.mkShell {
                    inherit nativeBuildInputs buildInputs;
                };
            }
        );
}
