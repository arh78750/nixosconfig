{
  config,
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = [unstable.clonehero];
}
