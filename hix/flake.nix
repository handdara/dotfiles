{
    description = "handdara nixos flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        kmonad = {
            url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-matlab = {
            # see https://gitlab.com/doronbehar/nix-matlab for more
            url = "gitlab:doronbehar/nix-matlab";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-vimrc = {
            url = "github:handdara/nix-vimrc/main";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware.url = "github:NixOS/nixos-hardware";
    };

    outputs = {
        nixpkgs,
        home-manager,
        nix-matlab,
        nix-vimrc,
        nixos-hardware,
        ...
    } @ inputs: let
        system-overlays = [nix-matlab.overlay];
        lib = nixpkgs.lib;
        hmlib = home-manager.lib;
        pkgs = nixpkgs.legacyPackages.${system};
        system = "x86_64-linux";
        timezone = "America/New_York";
        user_opts = rec {
            username = "handdara";
            name = username;
            email = "email@handdara.com";
        };
    in {
        nixosConfigurations = {
            sha76 = lib.nixosSystem {
                modules = [
                    ./configuration.nix
                    inputs.kmonad.nixosModules.default
                    ./games/minecraft
                    ./games/steam
                ];
                specialArgs = {
                    inherit system timezone user_opts system-overlays;
                    hostname = "sha76";
                };
            };
            mixed = lib.nixosSystem {
                modules = [
                    ./configuration.nix
                    inputs.kmonad.nixosModules.default
                    nixos-hardware.nixosModules.apple-t2
                ];
                specialArgs = {
                    inherit system timezone user_opts system-overlays;
                    hostname = "mixed";
                };
            };
            theseus = lib.nixosSystem {
                modules = [
                    ./configuration.nix
                ];
                specialArgs = {
                    inherit system timezone user_opts;
                    hostname = "theseus";
                };
            };
        };
        homeConfigurations = {
            handdara = hmlib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    ./home.nix
                ];
                extraSpecialArgs = {
                    inherit user_opts nix-vimrc;
                };
            };
        };
    };
}
