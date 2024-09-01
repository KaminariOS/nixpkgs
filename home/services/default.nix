let
  more = {
    services = {
      flameshot.enable = true;
      gnome-keyring.enable = true;
      blueman-applet.enable = true;
      kdeconnect = {
        enable = true;
        indicator = true;
      };
      #taskwarrior-sync.enable = true;
    };
  };
in [
  ./dunst
  ./gpg-agent
  ./networkmanager
  ./picom
  ./polybar
  ./screenlocker
  ./udiskie
  ./i3
  ./eww
  ./espanso
  more
]
