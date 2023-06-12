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

    wireshark
    # HDR image viewer
    tev

    maim
    gdbgui
    zettlr

    obs-studio
    #blender
    steam
    #heroic
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
