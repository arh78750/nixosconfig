{pkgs}:
pkgs.writeShellScriptBin "autohypr" ''
  ${pkgs.swww}/bin/swww init &
  ${pkgs.goxlr-utility}/bin/goxlr-launcher &
  ${pkgs.swww}/bin/swww img ~/.config/wallpaper.png &
''
