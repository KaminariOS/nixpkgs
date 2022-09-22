{ config, pkgs, ... }:

let
#  configHome = "${config.homeDirectory}/.config";
  defaultPkgs = with pkgs; [
    any-nix-shell
    arandr # simple GUI for xrandr
    asciinema # record the terminal
    cachix # nix caching

    bottom # alternative to htop & ytop
    du-dust # disk usage/free utility
    exa # a better `ls`
    fd # "find" for files
    gimp # gnu image manipulation program
    hyperfine # command-line benchmarking tool
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
    taplo
    sumneko-lua-language-server
    #    wgsl_analyzer
    #  nodePackages_latest.yaml-language-server
    python-language-server

    simplescreenrecorder # screen recorder gui
#    kitty
    fish
    rofi

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

#    alacritty
    fortune
  ];

in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  targets.genericLinux.enable = true;

  imports = (import ./programs);

  news.display = "silent";

  xdg = {
#    inherit configHome;
    enable = true;
  };

  home = {
    stateVersion = "22.05";
    packages = defaultPkgs;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
    };
  };
    # restart services on change
  systemd.user.startServices = "sd-switch";

  programs = {
    bat.enable = true;
    direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
    broot = {
          enable = true;
          enableFishIntegration = true;
        };
    zoxide = {
          enable = true;
          enableFishIntegration = true;
          options = [];
        };
    starship = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
    };
  };

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
