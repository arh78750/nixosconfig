{
  config,
  profile,
  lib,
  pkgs,
  ...
}: {
  options = {
    hyprconf.profile = lib.mkOption {
      type = lib.types.str;
      default = "development";
    };
  };

  config = {
    home.file.".config/hypr" = {
      source = ../../configfiles/hypr-${config.hyprconf.profile};
      recursive = true;
    };
  };
  # Config information https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509
}
