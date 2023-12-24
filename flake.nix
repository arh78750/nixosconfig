{
  description = "system flake config for THE FWEK";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
      url = "github:jordanisaacs/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  outputs = inputs@{ self, nixpkgs, home-manager, neovim-flake, ... }:
  let
    # -- SYSTEM SETTINGS -- #
    system = "x86_64-linux";
    hostname = "phantom";
    # -- USER SETTINGS -- #
    username = "andrew";
    name = "andrew";
  in {
    nixosConfigurations = {
      phantom = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andrew = import ./nixos/home.nix;
          }
        ];
        specialArgs = {
          inherit system;
          inherit hostname;
          inherit username;
          inherit name;
        };
      };
    };
  };
}
