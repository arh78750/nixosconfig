{
  config,
  profile,
  ...
}: {
  home.file.".config/hypr" = {
    source = ../../configfiles/hypr;
    recursive = true;
  };

  # Config information https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509
}
