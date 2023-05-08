let
  more = {
    services = {
      flameshot.enable = true;
      gnome-keyring.enable = true;
    };
  };
in
[
  ./dunst
  ./gpg-agent
  ./networkmanager
   ./picom
  ./polybar
  ./screenlocker
  ./udiskie
  ./i3
  ./eww
  more
]
