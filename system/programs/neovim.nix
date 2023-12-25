{
  config,
  pkgs,
  neovim-flake,
  ...
}: {
  environment.systemPackages = [neovim-flake.packages.${pkgs.system}.nix];

  # Config information https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509
}
