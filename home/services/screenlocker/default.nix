{pkgs, ...}: {
  services.screen-locker = {
    enable = true;
    inactiveInterval = 3600;
    #lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l blur";
    lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l --off 30";
    #    xautolock.extraOptions = [
    #      "Xautolock.killer: systemctl suspend"
    #    ];
  };
}
