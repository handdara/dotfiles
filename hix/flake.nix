{
    description = "handdara nixos flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-25.05";
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
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };
    };

    outputs = {
        nixpkgs,
        nixpkgs-unstable,
        home-manager,
        nix-matlab,
        nix-vimrc,
        ...
    } @ inputs: let
        flake-overlays = [nix-matlab.overlay];
        system = "x86_64-linux";
        lib = nixpkgs.lib;
        hmlib = home-manager.lib;
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs_unstable = nixpkgs-unstable.legacyPackages.${system};
        useLight = lib.mkDefault false;
        user_opts = rec {
            inherit useLight;
            username = "handdara";
            name = username;
            email = "${username}.core@proton.me";
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
                    extraModules = [./battery.nix];
                    sys_opts = import ./machines/sha76/options.nix {};
                };
            };
            theseus = lib.nixosSystem {
                modules = [
                    ./configuration.nix
                    # inputs.kmonad.nixosModules.default
                ];
                specialArgs = {
                    inherit system user_opts;
                    extraModules = [];
                    sys_opts = import ./machines/theseus/options.nix {};
                };
            };
            tadok = lib.nixosSystem {
                modules = [
                    ./configuration.nix
                    # inputs.kmonad.nixosModules.default
                ];
                specialArgs = {
                    inherit system user_opts;
                    extraModules = [./battery.nix];
                    sys_opts = import ./machines/tadok/options.nix {};
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
                    inherit user_opts pkgs_unstable nix-vimrc;
                };
            };
        };
    };
}
