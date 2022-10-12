let
  more = {
    programs = {
       bat.enable = true;
       direnv = {
             enable = true;
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
       ssh.enable = true;

       zoxide = {
             enable = true;
             enableFishIntegration = true;
             options = [];
           };
       starship = {
           enable = true;
           enableFishIntegration = true;
           enableZshIntegration = true;
       };
       navi = {
           enable = true;
           enableZshIntegration = true;
           enableFishIntegration = true;
       };
       skim = {
           enable = true;
           enableFishIntegration = true;
           enableZshIntegration = true;
       };
       atuin = {
           enable = true;
           enableFishIntegration = true;
           enableZshIntegration = true;
       };
     };
  };
in
[
  ./alacritty
  ./autorandr
  ./helix
  ./kitty
  ./nushell
  ./nvim
  ./starship
  ./starship/symbols.nix
  ./zellij
  #./dconf
  ./git
  ./fish
  ./neofetch
  ./nheko
  ./orage
  ./rofi
  # ./xmonad
  ./yubikey
  more
]
