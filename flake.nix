{
  description = "system flake config for THE FWEK";

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    neovim-flake,
    ...
  }: let
    # -- SYSTEM SETTINGS -- #
    system = "x86_64-linux";
    hostname = "phantom";
    profile = "development";
    # -- USER SETTINGS -- #
    username = "andrew";
    name = "andrew";
    # create patched nixpkgs
    nixpkgs-patched = (import nixpkgs {inherit system;}).applyPatches {
      name = "nixpkgs-patched";
      src = nixpkgs;
      patches = [
        ./patches/alsa-ucm-conf-fix.patch
      ];
    };
    # configure pkgs
    pkgs = import nixpkgs-patched {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  in {
    nixosConfigurations = {
      phantom = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit pkgs;
        modules = [
          (./. + "/profiles" + ("/" + profile) + "/configuration.nix")
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andrew = import (./. + "/profiles" + ("/" + profile) + "/home.nix");
          }
        ];
        specialArgs = {
          inherit system;
          inherit hostname;
          inherit username;
          inherit name;
          inherit (inputs) neovim-flake;
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
      url = "github:jordanisaacs/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
