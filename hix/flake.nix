{
    description = "handdara nixos flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        kmonad = {
            url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, nixpkgs-unstable, home-manager, ...}@inputs: 
        let
            user_opts = rec {
                username = "handdara";
                name = username;
                email = "${username}.core@proton.me";
                which_nvim = "nrw";
                term_invert = false;
            };
            system = "x86_64-linux";
            lib = nixpkgs.lib;
            hmlib = home-manager.lib;
            pkgs = nixpkgs.legacyPackages.${system};
            pkgs_unstable = nixpkgs-unstable.legacyPackages.${system};
        in 
            {
            nixosConfigurations = {
                sha76 = lib.nixosSystem {
                    modules = [
                        ./configuration.nix
                        inputs.kmonad.nixosModules.default
                    ];
                    specialArgs = {
                        inherit system user_opts;
                        sys_opts = import ./machines/sha76/options.nix {};
                    };
                };
                theseus = lib.nixosSystem {
                    modules = [
                        ./configuration.nix
                        inputs.kmonad.nixosModules.default
                    ];
                    specialArgs = {
                        inherit system user_opts;
                        sys_opts = import ./machines/theseus/options.nix {};
                    };
                };
                tadok = lib.nixosSystem {
                    modules = [
                        ./configuration.nix
                        inputs.kmonad.nixosModules.default
                    ];
                    specialArgs = {
                        inherit system user_opts;
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
                        inherit user_opts pkgs_unstable;
                    };
                };
            };
        };
}
