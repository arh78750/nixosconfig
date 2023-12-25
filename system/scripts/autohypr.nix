{pkgs}:
pkgs.writeShellScriptBin "autohypr" ''
  sleep 1
  ${pkgs.swww}/bin/swww init &
  ${pkgs.goxlr-utility}/bin/goxlr-launcher &
  ${pkgs.swww}/bin/swww img ~/.config/hypr/wallpaper.jpg &
''
