{
  description = "system flake config for THE FWEK";

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    unstable,
    neovim-flake,
    ...
  }: let
    # -- SYSTEM SETTINGS -- #
    system = "x86_64-linux";
    # -- USER SETTINGS -- #
    username = "andrew";
    name = "andrew";
    # create patched nixpkgs
    #    nixpkgs-patched = (import nixpkgs {inherit system;}).applyPatches {
    #      name = "nixpkgs-patched";
    #      src = nixpkgs;
    #      patches = [
    #        ./patches/alsa-ucm-conf-fix.patch ## so shoulda thought of this but patching alsa makes anything that depends on it rebuild which is A LOT. Computer ran out of memory while building
    #      ];
    #    };
    #    # configure pkgs
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
        permittedInsecurePackages = [
          "electron-25.9.0"
          "openssl-1.1.1w"
        ];
      };
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      phantom = nixpkgs.lib.nixosSystem {
        inherit system; # pass system to the nixosSystem Function
        inherit lib;
        inherit pkgs;
        modules = [
          (./. + "/profiles/phantom/configuration.nix")
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andrew = import (./. + "/profiles/phantom/home.nix");
          }
        ];
        specialArgs = {
          # pass vars to all the modules
          inherit system;
          inherit username;
          inherit name;
          inherit inputs;
          inherit (inputs) neovim-flake;
          unstable = import unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
      };
      vega = nixpkgs.lib.nixosSystem {
        inherit system; # pass system to the nixosSystem Function
        modules = [
          (./. + "/profiles/vega/configuration.nix")
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andrew = import (./. + "/profiles/vega/home.nix");
          }
        ];
        specialArgs = {
          # pass vars to all the modules
          inherit system;
          inherit username;
          inherit name;
          inherit (inputs) neovim-flake;
          inherit inputs;
          unstable = import unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    unstable.url = "nixpkgs/nixos-unstable";

    nix-gaming.url = "github:fufexan/nix-gaming";
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
