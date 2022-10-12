let
  more = {
    services = {
      flameshot.enable = true;
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
  more
]
