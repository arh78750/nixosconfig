{pkgs}:
pkgs.writeShellScriptBin "autohypr" ''
  ${pkgs.swww}/bin/swww init &
  ${pkgs.swww}/bin/swww img ~/.config/wallpaper.png &
''
