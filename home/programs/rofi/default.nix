{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.wezterm}/bin/wezterm";
    theme = ./launcher/type2-style-10.rasi;
  };
}
