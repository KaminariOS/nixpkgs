{
  config,
  pkgs,
  lib,
  ...
}: let
  shellPkgs = import ../shellEnv/shellList.nix pkgs;
  mimeTypes = import ./mimeTypes.nix;
  defaultPkgs = with pkgs; [
    arandr # simple GUI for xrandr
    asciinema # record the terminal

    # gimp # gnu image manipulation program

    betterlockscreen # fast lockscreen based on i3lock

    # nodePackages_latest.bash-language-server
    #    nodePackages.dockerfile-language-server-nodejs

    # simplescreenrecorder # screen recorder gui
  ];

  gui_apps = (import ./gui.nix pkgs).gui_packages;
  nixos_app = with pkgs; [
    jetbrains.clion
    jetbrains.idea-ultimate
    google-chrome
    rclone
    seahorse
    pulseaudio
  ];
  inherit (config.home) homeDirectory;
in {
  imports =
    builtins.concatMap import [
      #      ./age
      ./programs
      ./scripts
      ../shellEnv
      ./services
      #      ./themes
    ]
    ++ [
      ./options.nix
      ./stylix.nix
    ];
  home = {
    stateVersion = "22.05";
    #    packages = defaultPkgs ++ gnomePkgs;
    packages = defaultPkgs ++ shellPkgs ++ gui_apps ++ nixos_app;
    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERM_PROGRAM = "WezTerm";
      QT_SCALE_FACTOR = 2;
      GDK_SCALE = 2;
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-rime fcitx5-chinese-addons fcitx5-mozc];
  };
  # restart services on change
  systemd.user = {
    targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = ["graphical-session-pre.target"];
      };
    };
    startServices = "sd-switch";
    timers.wallpaper = {
      Install.WantedBy = ["timers.target"];
      Timer = {
        OnBootSec = "40m";
        OnUnitActiveSec = "1d";
      };
    };
    services = {
      imec = {
        Unit.Description = "...";
        Service.ExecStart = "${config.home.homeDirectory}/.nix-profile/bin/fcitx5";
        Install.WantedBy = ["default.target"]; # starts after login
      };
      rclone = {
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.rclone}/bin/rclone mount --umask 022  --allow-other remote: %h/rclone --vfs-cache-mode full --vfs-fast-fingerprint --vfs-cache-max-size 10G";
          ExecStop = "umount ${homeDirectory}/rclone";
          Environment = ["PATH=/run/wrappers/bin/:$PATH"];
        };
        Install.WantedBy = ["default.target"];
      };
      edu = {
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.rclone}/bin/rclone mount --umask 022  --allow-other unc: %h/unc --vfs-cache-mode full --vfs-fast-fingerprint --vfs-cache-max-size 10G";
          ExecStop = "umount ${homeDirectory}/unc";
          Environment = ["PATH=/run/wrappers/bin/:$PATH"];
        };
        Install.WantedBy = ["default.target"];
      };
      wallpaper = {
        Service = {
          Type = "oneshot";
          ExecStart = "${homeDirectory}/nixpkgs/wallpaper/wallpaper.sh";
          #''${pkgs.wget}/bin/wget -O wallpaper.jpg "http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)" -O ${homeDirectory}/Pictures/wallpaper.jpg &&
          #${pkgs.feh}/bin/feh --bg-scale /Pictures/wallpaper.jpg'';
          Environment = ["PATH=/run/current-system/sw/bin:${homeDirectory}/.nix-profile/bin:$PATH"];
        };
        #Install.WantedBy = ["default.target"];
        Install.WantedBy = ["default.target"];
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      mkDefaults = files: desktopFile: lib.genAttrs files (_: [desktopFile]);
      audioTypes =
        mkDefaults mimeTypes.audioFiles
        "defaultAudioPlayer.desktop";

      browserTypes =
        mkDefaults mimeTypes.browserFiles
        "defaultWebBrowser.desktop";

      documentTypes =
        mkDefaults mimeTypes.documentFiles
        "defaultPdfViewer.desktop";

      editorTypes =
        mkDefaults mimeTypes.editorFiles
        "defaultEditor.desktop";

      folderTypes = {"inode/directory" = "defaultFileManager.desktop";};

      imageTypes =
        mkDefaults mimeTypes.imageFiles
        "defaultImageViewer.desktop";

      videoTypes =
        mkDefaults mimeTypes.videoFiles
        "defaultVideoPlayer.desktop";
    in
      audioTypes
      // browserTypes
      // documentTypes
      // editorTypes
      // folderTypes
      // imageTypes
      // videoTypes;
  };
  xdg.desktopEntries = let
    mkDefaultEntry = name: package: {
      name = "Default ${name}";
      exec = "QT_SCALE_FACTOR=2 ${lib.getExe package} %U";
      terminal = false;
      settings = {
        NoDisplay = "true";
      };
    };
  in {
    # defaultAudioPlayer = mkDefaultEntry "Audio Player" cfg.audioPlayer;
    # defaultEditor = mkDefaultEntry "Editor" cfg.editor;
    # defaultFileManager = mkDefaultEntry "File Manager" cfg.fileManager;
    # defaultImageViewer = mkDefaultEntry "Image Viewer" cfg.imageViewer;
    defaultPdfViewer = mkDefaultEntry "PDF Viewer" pkgs.okular;
    # defaultVideoPlayer = mkDefaultEntry "Video Player" cfg.videoPlayer;
    # defaultWebBrowser = mkDefaultEntry "Web Browser" cfg.webBrowser;
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

  home.pointerCursor = {
    # x11.enable = true;
    # name = "Adwaita";
    # package = pkgs.gnome.adwaita-icon-theme;
    # name = "WhiteSur-cursors";
    # package = pkgs.whitesur-cursors;
    # name = "Bibata-Modern-Ice";
    # package = pkgs.bibata-cursors;
    # size = 60;
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };
    # theme = {
    #   name = "WhiteSur-Dark-hdpi";
    #   package = pkgs.whitesur-gtk-theme;
    # };
    # font = {
    #   name = "Noto fonts";
    #   package = pkgs.noto-fonts;
    #   size = 24;
    # };
  };
}
