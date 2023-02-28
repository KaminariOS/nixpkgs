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

    blender
    gparted
    steam
    heroic

    mdcat
    #wezterm
    xdotool

    via
  ];

}
