{ config, pkgs, ... }:
{
  gui_packages = with pkgs; [
    i3status
    brightnessctl
    #    polybar
    feh
    zoom-us
    discord
    slack
    telegram-desktop

    wireshark
    # HDR image viewer
    tev

    maim
    gdbgui
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
    networkmanager_dmenu
    networkmanagerapplet
    inlyne
    graphviz
  ];

}
