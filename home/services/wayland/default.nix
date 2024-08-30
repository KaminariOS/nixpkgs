{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.ar.home.desktop.sway.enable {
    ar.home = {
      apps = {
        rofi.enable = lib.mkDefault true;
        swaylock.enable = lib.mkDefault true;
      };

      services = {
        mako.enable = lib.mkDefault true;
        pipewire-inhibit.enable = lib.mkDefault true;
        swayidle.enable = lib.mkDefault true;
        swayosd.enable = lib.mkDefault true;
        waybar.enable = lib.mkDefault true;
      };
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/wm/preferences".button-layout = "";
        "org/gnome/nm-applet".disable-connected-notifications = true;
      };
    };

    home.packages = with pkgs; [
      blueberry
      file-roller
      libnotify
      networkmanagerapplet
    ];

    services.playerctld.enable = lib.mkDefault true;

    xdg.portal = {
      enable = true;
      # extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };
}
