{
  description = "system flake config for THE FWEK";
  inputs = {
    nixpgs.url = "nixpkgs/nixos-23.11";
  };
  outputs = { self, nixpkgs, ... }:
  let 
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
    phantom = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos/configuration.nix ];
      };
    };
  };

}
