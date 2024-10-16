{
  description = "handdara sha76 flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    kmonad = {
      url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, kmonad, ...}: 
    let
      # SYSTEM SETTINGS
      sysSettings = rec {
        system = "x86_64-linux";
        hostname = "sha76";
        timezone = "America/New_York";
        locale = "en_US.UTF-8";
        useDisplayLink = true;
      };
      # USER SETTINGS
      userSettings = rec {
        username = "handdara";
        name = "handdara";
        email = "handdara.core@proton.me";
        browser = "firefox";
        editor = "nvim";
      };
      lib = nixpkgs.lib;
      hmlib = home-manager.lib;
      pkgs = nixpkgs.legacyPackages.${sysSettings.system};
    in {
    nixosConfigurations = {
      sha76 = lib.nixosSystem {
        system = sysSettings.system;
        modules = [
          ./configuration.nix
          kmonad.nixosModules.default
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
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit sysSettings;
          inherit userSettings;
        };
      };
    };
  };
}
