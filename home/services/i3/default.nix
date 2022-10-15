{ config, lib, pkgs, ... }:

let 
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraConfig = builtins.readFile ./config;
    config = {
      modifier = mod;

      window.border = 0;

      gaps = {
        inner = 10;
        outer = 3;
        smartBorders = "on";
        smartGaps = true;
      };

      assigns = {
        "1" = [{class = "kitty";}];
      };

      defaultWorkspace = "workspace number 9";
  
      terminal = "kitty";
      

      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        # "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";
#        "${mod}+Shift+x" = "exec i3lock-fancy-dualmonitor";
        "${mod}+Shift+x" = "exec loginctl lock-session";
        "${mod}+Return" = "exec kitty; workspace1";
        "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";
        "${mod}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

   #     "${mod}+1" = "workspace Terminal";

        # My multi monitor setup
        "${mod}+m" = "move workspace to output DP-2";
        "${mod}+Shift+m" = "move workspace to output DP-5";

        "${mod}+Tab" = "fullscreen toggle , focus right, fullscreen toggle";
        "${mod}+Shift+Tab" = "fullscreen toggle , focus left, fullscreen toggle";
      };

      bars = [
      ];

      startup = [
        {
          command = "exec --no-startup-id i3-msg 'workspace 1; exec kitty'";
          always = true;
          notification = false;
        }
        {
          command = "exec --no-startup-id picom -CGb";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart polybar.service";
          always = true;
          notification = false;
        }
        {
          command = "wget https://source.unsplash.com/random/3840x2160 -O ~/Pictures/wallpaper.jpg && ${pkgs.feh}/bin/feh --bg-scale ~/Pictures/wallpaper.jpg";
          always = true;
          notification = false;
        }
      ];
    };
  };
}
