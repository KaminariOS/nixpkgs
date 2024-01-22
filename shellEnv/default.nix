let
  more = {
    home.file = {
      ".ssh/config".text = ''
        Host *.cloudlab.us
          ForwardAgent yes
          forwardX11Trusted yes
      '';
      ".gdbinit".text = ''
        set auto-load safe-path / 
        tui enable 
      '';
    };
    programs = {
      readline = {
        enable = true;
        extraConfig = "set editing-mode vi
          ";
      };
      direnv = {
        enable = true;
        #enableFishIntegration = true;
        nix-direnv.enable = true;
      };
      broot = {
        enable = true;
        enableFishIntegration = true;
      };

      fzf = {
        enable = true;
        enableFishIntegration = true;
        defaultCommand = "fd --type file --follow"; # FZF_DEFAULT_COMMAND
        defaultOptions = [ "--height 20%" ]; # FZF_DEFAULT_OPTS
        fileWidgetCommand = "fd --type file --follow"; # FZF_CTRL_T_COMMAND
      };

      gpg.enable = true;
      ssh = {
        enable = true;
      };
      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [ ];
      };
      starship = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
      nix-index = {
        enable = true;
        enableFishIntegration = true;
      };
      #oh-my-posh = {
      #enable = true;
      #enableFishIntegration = true;
      #};
      #scmpuff = {
      #enable = true;
      #enableFishIntegration = true;
      #};
      #z-lua = {
      #enable = true;
      #enableFishIntegration = true;
      #};
      navi = {
        enable = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };
      skim = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        changeDirWidgetCommand = "fd --type d";
        fileWidgetOptions = [
          "--preview 'head {}'"
        ];
      };
      atuin = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
      tealdeer = {
        enable = true;
        settings = {
          updates = {
            auto_update = true;
          };
        };
      };
    };
  };
in
[
  ./helix
  ./nushell
  ./nvim
  #./neovim
  ./starship
  ./zellij
  ./git
  ./fish
  ./neofetch
  ./terminfo.nix
  ./nix-index.nix
  ./bat
  # ./xplr
  ./gitui
  more
]
