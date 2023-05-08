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
    zettlr

    obs-studio
    #blender
    gparted
    steam
    #heroic
    mpv
    mdcat
    wezterm
    xdotool
    via

   inlyne
  ];

}
