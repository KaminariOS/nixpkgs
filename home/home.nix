{ config, pkgs, lib, stdenv, ... }:

let
  username = "kosumi";
    homeDirectory = "/home/${username}";
    configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    any-nix-shell
    xclip
    arandr # simple GUI for xrandr
    asciinema # record the terminal
    cachix # nix caching

    gimp # gnu image manipulation program
    killall # kill processes by name

    multilockscreen # fast lockscreen based on i3lock
    nyancat # the famous rainbow cat!
    ranger # terminal file explorer
    direnv

    rnix-lsp # nix lsp server
    rust-analyzer
    # nodePackages_latest.bash-language-server
    #   nodePackages_latest.vscode-css-languageserver-bin
    #    nodePackages.dockerfile-language-server-nodejs
    gopls
    haskell-language-server
    java-language-server
    #   nodePackages.vscode-json-languageserver
    texlab
    taplo-lsp # A TOML toolkit written in Rust
    sumneko-lua-language-server
    #    wgsl_analyzer
    #  nodePackages_latest.yaml-language-server
    python-language-server
    cmake-language-server

    simplescreenrecorder # screen recorder gui
#    kitty
    fish
    rofi

    gdbgui


#    alacritty
    fortune
    neofetch

    nyancat              # the famous rainbow cat!
    prettyping           # a nicer ping
    xsel                 # clipboard support (also for neovim)

    zip 
    unzip
  ];
  rust_cli = with pkgs; [
    nushell
    tealdeer
    zoxide
    tokei
    procs
    starship
    gitui
    sd
    bandwhich
    hexyl
    atuin
    broot
    delta
    helix
    zellij
    ripgrep # fast grep
    navi # cheatsheet
    skim

    bottom # alternative to htop & ytop
    du-dust # disk usage/free utility
    exa # a better `ls`
    fd # "find" for files
    hyperfine # command-line benchmarking tool
    ripgrep-all
    xplr
    rustscan
    grex # A command-line tool for generating regular expressions from user-provided test cases
    pstree
  ];
  gui_apps = with pkgs; [
    i3-gaps
    i3status
    brightnessctl

#    polybar
    feh
    zoom-us
    libsForQt5.kdeconnect-kde
  ];
  nixos_app = with pkgs; [
    jetbrains.clion
    jetbrains.idea-ultimate
    kitty
    i3status
    google-chrome
    rclone
    libsForQt5.kio-gdrive
    libsForQt5.kdeconnect-kde
    firefox
    kate
    zoom-us

    wireshark
    tev
  ];
in
{
    imports = builtins.concatMap import [
#      ./age
       ./programs
      ./scripts
      ./services
#      ./themes
    ];

    xdg = {
      inherit configHome;
      enable = true;
    };
    home = {
      inherit username homeDirectory;
      stateVersion = "22.05";

  #    packages = defaultPkgs ++ gnomePkgs;
      packages = defaultPkgs ++ rust_cli ++ gui_apps ++ nixos_app;

      sessionVariables = {
        DISPLAY = ":0";
        EDITOR = "nvim";
      };
    };

    # restart services on change
    systemd.user = {
      startServices = "sd-switch";

    services = {
      imec = {
        Unit.Description = "...";
        Service.ExecStart = "/run/current-system/sw/bin/fcitx5";
        Install.WantedBy = [ "default.target" ]; # starts after login
    };
      rclone = {
        Service = {
          Type = "notify";
          ExecStart = "${pkgs.rclone}/bin/rclone mount --umask 022  --allow-other remote: %h/rclone";
          Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
        };
        Install.WantedBy = ["default.target"];
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
