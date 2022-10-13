{ pkgs, ... }:

{
  services.screen-locker = {
    enable = true;
    inactiveInterval = 30;
    lockCmd = "${pkgs.
betterlockscreen}/bin/betterlockscreen -l blur";
#    xautolock.extraOptions = [
#      "Xautolock.killer: systemctl suspend"
#    ];
  };
}
