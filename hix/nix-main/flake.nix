{
  description = "handdara sha76 flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, ...}: 
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      hmlib = home-manager.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      sha76 = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
    };
    homeConfigurations = {
      handdara = hmlib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
