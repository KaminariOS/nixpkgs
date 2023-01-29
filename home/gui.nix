{config, pkgs, ...}:
{
  gui_packages = with pkgs; [
    i3-gaps
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
  ];

}
