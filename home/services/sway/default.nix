{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.ar.home.desktop.sway.enable {
    wayland.windowManager.sway = import ./settings.nix {inherit config lib pkgs;};
    ar.home.services.randomWallpaper.enable = true;

    xdg.portal = {
      enable = true;
      configPackages = [pkgs.xdg-desktop-portal-wlr];
      extraPortals = [pkgs.xdg-desktop-portal-wlr];
    };
  };
}
