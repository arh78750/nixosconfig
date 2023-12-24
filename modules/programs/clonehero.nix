{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.clone-hero];
  # Config information https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509
}
