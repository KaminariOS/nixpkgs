{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    #enableFishIntegration = true;
    settings = {
      default_shell = "${pkgs.fish}/bin/fish";
      theme = "Tokyo Night Storm";
      copy_command = "xclip -selection clipboard";
      #keybinds = {
        #normal = {
          ##"bind \"Ctrl 4\"" = {NewTab = ";"; };
        #};
      #};
    };
  };
  xdg.configFile."zellij/config.kdl".text = ''
    keybinds {
      unbind "Ctrl t"
      normal {
        bind "Ctrl u" {SwitchToMode "tab"; }
      }
      pane {
          bind "Ctrl u" {SwitchToMode "tab"; }
        }
      tab {
          bind "Ctrl u" {SwitchToMode "tab"; }
        }
      session {
          bind "Ctrl u" {SwitchToMode "tab"; }
        }
      }
  '';
}
