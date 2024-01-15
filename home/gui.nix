{ config, pkgs, ... }:
{
  gui_packages = with pkgs; [
    # i3status
    brightnessctl
    feh
    zoom-us
    discord
    slack
    telegram-desktop

    wireshark
    # HDR image viewer
    # tev

    maim
    gdbgui
    # Your One-Stop Publication Workbench 
    zettlr

    obs-studio
    #blender
    steam
    # heroic
    lutris
    mpv
    mdcat
    xdotool
    via
    # networkmanager_dmenu
    networkmanagerapplet
    # Inlyne - a GPU powered, browserless, markdown + html viewer
    inlyne
    graphviz

    # File manager
    gnome.nautilus

    steam-run

    okular
    oculante 
  ];

}
