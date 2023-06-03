{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      default_shell = "${pkgs.fish}/bin/fish";
      theme = "Tokyo Night Storm";
      copy_command = "xclip -selection clipboard";
      keybinds = {
        normal = {
          #"bind \"Ctrl 4\"" = {NewTab = ";"; };
        };
      };
    };
  };
  xdg.configFile."zellij/config.kdl".text = ''
    keybinds {
      normal {
          bind "Ctrl 4" {NewTab;}
        }
      pane {
          bind "Ctrl 4" {NewTab;}
        }
      tab {
          bind "Ctrl 4" {NewTab;}
        }
      session {
          bind "Ctrl 4" {NewTab;}
        }
      }
  '';
}
