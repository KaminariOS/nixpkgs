{ pkgs, ... }:
{
  home.file.".terminfo" = {
    source = pkgs.symlinkJoin {
      name = "terminfo";
      paths = with pkgs; [
        kitty.terminfo
        alacritty.terminfo
        wezterm.terminfo
      ];
      postBuild = ''
        mv $out/share/terminfo/* $out/
        rm -rf $out/share
      '';
    };
  };
}
