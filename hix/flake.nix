{
    description = "handdara nixos flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
        flake-overlays = [nix-matlab.overlay];
        system = "x86_64-linux";
        lib = nixpkgs.lib;
        hmlib = home-manager.lib;
        pkgs = nixpkgs.legacyPackages.${system};
        user_opts = rec {
            username = "handdara";
            name = username;
            email = "email@handdara.com";
            which_nvim = "sm";
        };
    in {
        nixosConfigurations = {
            sha76 = lib.nixosSystem {
                modules = [
                    (import ./configuration.nix flake-overlays)
                    inputs.kmonad.nixosModules.default
                    ./games/minecraft
                    ./games/steam
                ];
                specialArgs = {
                    inherit system user_opts;
                    extraModules = [];
                    sys_opts = import ./machines/sha76/options.nix {};
                };
            };
            mixed = lib.nixosSystem {
                modules = [
                    (import ./configuration.nix flake-overlays)
                    inputs.kmonad.nixosModules.default
                    nixos-hardware.nixosModules.apple-t2
                    ./battery.nix
                ];
                specialArgs = {
                    inherit system user_opts;
                    extraModules = [];
                    sys_opts = import ./machines/mixed/options.nix {};
                };
            };
            theseus = lib.nixosSystem {
                modules = [
                    ./configuration.nix
                ];
                specialArgs = {
                    inherit system user_opts;
                    extraModules = [];
                    sys_opts = import ./machines/theseus/options.nix {};
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
