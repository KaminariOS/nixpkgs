{config, pkgs, ...}:
{
  gui_packages = with pkgs; [
    i3status
    brightnessctl
#    polybar
    feh
    zoom-us
    libsForQt5.kdeconnect-kde
    discord
    slack

    wireshark
    tev
    
    maim
    gdbgui
    haruna
    zettlr

    obs-studio
    #blender
    gparted
    steam
    #heroic
    smplayer
    mdcat
    wezterm
    xdotool
    via
  ];

}
