{pkgs, ...}: {
  services = {
    flameshot = {
      enable = true;
      package = pkgs.flameshot.overrideAttrs (oldAttrs: {
        cmakeFlags = [
          "-DUSE_WAYLAND_CLIPBOARD=1"
          "-DUSE_WAYLAND_GRIM=1"
        ];
        buildInputs = oldAttrs.buildInputs ++ [pkgs.libsForQt5.kguiaddons];
      });
    };
  };
}
