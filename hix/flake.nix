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
            opts = import ./options.nix {};
            lib = nixpkgs.lib;
            hmlib = home-manager.lib;
            pkgs = nixpkgs.legacyPackages.${opts.sys.system};
            pkgs_unstable = nixpkgs-unstable.legacyPackages.${opts.sys.system};
        in 
            {
            nixosConfigurations = {
                sha76 = lib.nixosSystem {
                    system = opts.sys.system;
                    modules = [
                        ./configuration.nix
                        inputs.kmonad.nixosModules.default
                    ];
                    specialArgs = {
                        inherit opts;
                    };
                };
                theseus = lib.nixosSystem {
                    system = opts.sys.system;
                    modules = [
                        ./configuration.nix
                        inputs.kmonad.nixosModules.default
                    ];
                    specialArgs = {
                        inherit opts;
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
                        inherit opts;
                        inherit pkgs_unstable;
                    };
                };
            };
        };
}
