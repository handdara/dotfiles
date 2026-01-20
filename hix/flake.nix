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
      url = "github:handdara/nix-vimrc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-matlab,
    nix-vimrc,
    nixos-hardware,
    nix-minecraft,
    ...
  } @ inputs: let
    system-overlays = [nix-matlab.overlay nix-minecraft.overlay];
    lib = nixpkgs.lib;
    hmlib = home-manager.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    system = "x86_64-linux";
    timezone = "America/New_York";
  in {
    nixosConfigurations = {
      sha76 = lib.nixosSystem {
        modules = [
          ./configuration.nix
          inputs.kmonad.nixosModules.default
          ./system/wm/awesomewm
          ./system/wm/xmonad
          ./games/minecraft
          nix-minecraft.nixosModules.minecraft-servers
          ./games/steam
          ./system/remote
        ];
        specialArgs = {
          inherit
            system
            timezone
            system-overlays
            ;
          hostname = "sha76";
          user_opts = rec {
            username = "handdara";
            name = username;
            email = "email@handdara.com";
          };
        };
      };
      mixed = lib.nixosSystem {
        modules = [
          ./configuration.nix
          ./system/wm/awesomewm
          inputs.kmonad.nixosModules.default
          nixos-hardware.nixosModules.apple-t2
          ./system/remote
        ];
        specialArgs = {
          inherit
            system
            timezone
            system-overlays
            ;
          hostname = "mixed";
          user_opts = rec {
            username = "estraven";
            name = username;
            email = "email@handdara.com";
          };
        };
      };
      theseus = lib.nixosSystem {
        modules = [
          ./configuration.nix
          inputs.kmonad.nixosModules.default
          ./system/wm/awesomewm
          ./system/wm/plasma
          ./games/minecraft
          nix-minecraft.nixosModules.minecraft-servers
          ./games/steam
        ];
        specialArgs = {
          inherit
            system
            timezone
            system-overlays
            ;
          hostname = "theseus";
          user_opts = rec {
            username = "estraven";
            name = username;
            email = "email@handdara.com";
          };
        };
      };
    };
    homeConfigurations = {
      handdara = hmlib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ./user/apps/matlab/r2022b
        ];
        extraSpecialArgs = {
          inherit nix-vimrc;
          user_opts = rec {
            username = "handdara";
            name = username;
            email = "email@handdara.com";
          };
        };
      };
      estraven = hmlib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ./user/apps/matlab/r2023a
        ];
        extraSpecialArgs = {
          inherit nix-vimrc;
          user_opts = rec {
            username = "estraven";
            name = username;
            email = "email@handdara.com";
          };
        };
      };
    };
  };
}
