{ pkgs, specialArgs, ... }:

let
  fontSize = 10;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      bell = {
        animation = "EaseOutExpo";
        duration = 5;
        color = "#ffffff";
      };
      colors = {
        primary = {
          background = "#040404";
          foreground = "#c5c8c6";
        };
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Medium";
        };
        size = fontSize;
      };
      selection.save_to_clipboard = true;
      shell = {
        program = "${pkgs.zellij}/bin/zellij";
        args = [ "options" "--default-shell" "fish" ];
      };
      window = {
        decorations = "full";
        opacity = 0.8;
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}
