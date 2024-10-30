{
  description = "handdara sha76 flake config";

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

  outputs = {/* self, */ nixpkgs, nixpkgs-unstable, home-manager, ...}@inputs: 
  let
    # SYSTEM SETTINGS
    sysSettings = {
      system = "x86_64-linux";
      hostname = "sha76";
      timezone = "America/New_York";
      locale = "en_US.UTF-8";
      useDisplayLink = true;
    };
    # USER SETTINGS
    userSettings = rec {
      username = "handdara";
      name = username;
      email = "${username}.core@proton.me";
      browser = "firefox";
    };
    lib = nixpkgs.lib;
    hmlib = home-manager.lib;
    pkgs = nixpkgs.legacyPackages.${sysSettings.system};
    pkgs_unstable = nixpkgs-unstable.legacyPackages.${sysSettings.system};
  in 
  {
    nixosConfigurations = {
      sha76 = lib.nixosSystem {
        system = sysSettings.system;
        modules = [
          ./configuration.nix
          inputs.kmonad.nixosModules.default
        ];
        specialArgs = {
          inherit sysSettings;
          inherit userSettings;
        };
      };
      nixvm = lib.nixosSystem {
        system = sysSettings.system;
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit sysSettings;
          inherit userSettings;
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
          inherit sysSettings;
          inherit userSettings;
          inherit pkgs_unstable;
        };
      };
    };
  };
}
