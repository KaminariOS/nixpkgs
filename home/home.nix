{ config, pkgs, lib, stdenv, ... }:

let
  shellPkgs = import ../shellEnv/shellList.nix pkgs;
  defaultPkgs = with pkgs; [
    arandr # simple GUI for xrandr
    asciinema # record the terminal

    gimp # gnu image manipulation program

    betterlockscreen # fast lockscreen based on i3lock

    # nodePackages_latest.bash-language-server
    #   nodePackages_latest.vscode-css-languageserver-bin
    #    nodePackages.dockerfile-language-server-nodejs
    #   nodePackages.vscode-json-languageserver

    simplescreenrecorder # screen recorder gui
    rofi
  ];


  gui_apps = (import ./gui.nix pkgs).gui_packages;
  nixos_app = with pkgs; [
    jetbrains.clion
    jetbrains.idea-ultimate
    i3status
    google-chrome
    rclone
    libsForQt5.kio-gdrive
    firefox
    gnome.seahorse
  ];
  inherit (config.home) homeDirectory;
in
{
  imports = builtins.concatMap import [
    #      ./age
    ./programs
    ./scripts
    ./services
    ../shellEnv
    #      ./themes
  ];

  home = {
    stateVersion = "22.05";
    #    packages = defaultPkgs ++ gnomePkgs;
    packages = defaultPkgs ++ shellPkgs ++ gui_apps ++ nixos_app;
    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
    };
  };

  # restart services on change
  systemd.user = {
    startServices = "sd-switch";
    timers.wallpaper = {
      Install.WantedBy = [ "timers.target" ];
      Timer = {
        OnBootSec = "40m";
        OnUnitActiveSec = "40m";
      };
    };
    services = {
      imec = {
        Unit.Description = "...";
        Service.ExecStart = "/run/current-system/sw/bin/fcitx5";
        Install.WantedBy = [ "default.target" ]; # starts after login
      };
      rclone = {
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.rclone}/bin/rclone mount --umask 022  --allow-other remote: %h/rclone --vfs-cache-mode full --vfs-fast-fingerprint --vfs-cache-max-size 10G";
          ExecStop = "umount ${homeDirectory}/rclone";
          Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
        };
        Install.WantedBy = [ "default.target" ];
      };
      wallpaper = {
        Service = {
          Type = "oneshot";
          ExecStart =
            "${homeDirectory}/nixpkgs/wallpaper/wallpaper.sh";
          #''${pkgs.wget}/bin/wget -O wallpaper.jpg "http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)" -O ${homeDirectory}/Pictures/wallpaper.jpg && 
          #${pkgs.feh}/bin/feh --bg-scale /Pictures/wallpaper.jpg'';
          Environment = [ "PATH=/run/current-system/sw/bin:${homeDirectory}/.nix-profile/bin:$PATH" ];
        };
        #Install.WantedBy = ["default.target"];
        Install.WantedBy = [ "default.target" ];
      };
    };
  };

  # notifications about home-manager news
  news.display = "silent";


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
