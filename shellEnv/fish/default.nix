{ config, pkgs, lib, ... }:

let
  fzfConfig = ''
    set -x FZF_DEFAULT_OPTS "--preview='bat {} --color=always'" \n
    set -x SKIM_DEFAULT_COMMAND "rg --files || fd || find ."
  '';

  themeConfig = ''
    set -g theme_display_date no
    set -g theme_display_git_master_branch no
    set -g theme_nerd_fonts yes
    set -g theme_newline_cursor yes
    set -g theme_color_scheme solarized
  '';

  custom = pkgs.callPackage ./plugins.nix {};

  fenv = {
    name = "foreign-env";
    src = pkgs.fishPlugins.foreign-env.src;
  };
  #aliases = ''
  #alias z  "zoxide"
  #alias nuco  "nvim ~/.config/nushell/config.nu"
  #alias hxco  "hx ~/.config/helix/config.toml"
  #alias alco  "nvim ~/.config/alacritty/alacritty.yml"
  #alias swim  "home-manager switch --flake '/home/kosumi/nixpkgs#kosumi'"
  #alias swir  "home-manager switch --flake '/home/kaminari/nixpkgs#kaminari'"
  #alias nico  "nvim ~/.config/nixpkgs/home.nix"
  #alias ll  "exa -l"
  #alias his  "history"
  #alias c  "bat"
  #alias lt  "exa --icons --tree --no-user --no-permissions"
  #alias e "exa --icons -l --no-user --no-permissions"
  #alias ls  "exa --icons -l --no-user --no-permissions"
  #alias du  "dust"
  #alias ps  "procs"
  #alias rfr  "rofi -show run"
  #alias diff "delta"
  #alias ca "cargo"
  #alias idea "idea-ultimate"
  #alias clo "clion"
  #alias dnix "echo 'use nix' >> .envrc; direnv allow"
  #'';
  fishConfig = "

    set -g fish_color_autosuggestion 555 yellow
    set -g fish_color_command 5f87d7
    set -g fish_color_comment 808080
    set -g fish_color_cwd 87af5f
    set -g fish_color_cwd_root 5f0000
    set -g fish_color_error 870000 --bold
    set -g fish_color_escape af5f5f
    set -g fish_color_history_current 87afd7
    set -g fish_color_host 5f87af
    set -g fish_color_match d7d7d7 --background=303030
    set -g fish_color_normal normal
    set -g fish_color_operator d7d7d7
    set -g fish_color_param 5f87af
    set -g fish_color_quote d7af5f
    set -g fish_color_redirection normal
    set -g fish_color_search_match --background=purple
    set -g fish_color_status 5f0000
    set -g fish_color_user 5f875f
    set -g fish_color_valid_path --underline

    set -g fish_color_dimmed 555
    set -g fish_color_separator 999

    # Git prompt status
    set -g __fish_git_prompt_showdirtystate 'yes'
    set -g __fish_git_prompt_showupstream auto
    set -g pure_git_untracked_dirty false

    # pure
    set pure_threshold_command_duration 1
    set pure_separate_prompt_on_error true
    set pure_begin_prompt_with_current_directory false
    set -U pure_color_success (set_color green)
    set -U pure_color_git_dirty (set_color cyan)

    # Status Chars
    #set __fish_git_prompt_char_dirtystate '*'
    set __fish_git_prompt_char_upstream_equal ''
    set __fish_git_prompt_char_upstream_ahead '↑'
    set __fish_git_prompt_char_upstream_behind '↓'
    set __fish_git_prompt_color_branch yellow
    set __fish_git_prompt_color_dirtystate 'red'

    set __fish_git_prompt_color_upstream_ahead ffb90f
    set __fish_git_prompt_color_upstream_behind blue

    # Local prompt customization
    # set -e fish_greeting


    set -g fish_pager_color_completion normal
    set -g fish_pager_color_description 555 yellow
    set -g fish_pager_color_prefix cyan
    set -g fish_pager_color_progress cyan


    # highlighting inside manpages and elsewhere
    set -gx LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
    set -gx LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
    set -gx LESS_TERMCAP_me \e'[0m'           # end mode
    set -gx LESS_TERMCAP_se \e'[0m'           # end standout-mode
    set -gx LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
    set -gx LESS_TERMCAP_ue \e'[0m'           # end underline
    set -gx LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline
    "
  + "
    fish_vi_key_bindings
    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block blink
    # Set the insert mode cursor to a line
    set fish_cursor_insert line blink
    # Set the replace mode cursor to an underscore
    set fish_cursor_replace_one underscore blink
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block blink

    function fish_greeting
      fortune -a
    end


    set -gx ATUIN_NOBIND true
    # bind to ctrl-r in normal and insert mode, add any other bindings you want here too
#    atuin init fish | source
    bind \\e\\[A _atuin_search
    bind -M insert \\e\\[A _atuin_search
    set_color normal
  " + fzfConfig + themeConfig; 
   #+ aliases;
in
{
  programs.fish = {
        enable = true;
        shellAbbrs = {
          v = "nvim";
    z  = "zoxide";
    nuco =  "nvim ~/.config/nushell/config.nu";
    hxco = "hx ~/.config/helix/config.toml";
    alco = "nvim ~/.config/alacritty/alacritty.yml";
    swim = "home-manager switch --flake '/home/kosumi/nixpkgs#kosumi'";
    swir = "home-manager switch --flake '/home/kaminari/nixpkgs#kaminari'";
    nico = "nvim ~/.config/nixpkgs/home.nix";
    ll = "exa -l";
    his = "history";
    c  = "bat";
    lt  = "exa --icons --tree --no-user --no-permissions";
    e = "exa --icons -l --no-user --no-permissions";
    ls = "exa --icons -l --no-user --no-permissions";
    du = "dust";
    ps  = "procs";
    rfr = "rofi -show run";
    diff = "delta";
    ca = "cargo";
    idea = "idea-ultimate";
    clo = "clion";
        };
        plugins = [ custom.theme fenv ];
            interactiveShellInit = ''
              eval (direnv hook fish)
              any-nix-shell fish --info-right | source
            '';
        shellInit = fishConfig;
  };

  xdg.configFile."fish/completions/keytool.fish".text = custom.completions.keytool;
  xdg.configFile."fish/functions/fish_prompt.fish".text = custom.prompt;
}
