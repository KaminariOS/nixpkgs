
{ lib, ... }:
{
  # Starship Prompt
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.starship.enable
  programs.starship.enable = true;

  programs.starship.settings = {
    # See docs here: https://starship.rs/config/
    # Symbols config configured ./starship-symbols.nix.

    directory = {
        style = "bg:#DA627D";
        format = "[ $path ]($style)";
        truncation_length = 20;
        truncation_symbol = "…/";
    };
    gcloud.disabled = true; # annoying to always have on
    hostname.style = "bold green"; # don't like the default
    memory_usage.disabled = true; # because it includes cached memory it's reported as full a lot
    username = {
    show_always = true;
    style_root = "bg:#9A348E";
    style_user = "bg:#9A348E";
    format = "[$user ]($style)";
    }; # don't like the default

    format = lib.concatStrings [
    "[](#9A348E)"
    "$sudo"
    "$username"
    "[](bg:#DA627D fg:#9A348E)"
    "$directory"
    "[](fg:#DA627D bg:#FCA17D)"
    "$git_branch"
    "$git_status"
    "[](fg:#FCA17D bg:#86BBD8)"
    "$c"
    "$golang"
    "$haskell"
    "$java"
    "$nodejs"
    "$rust"
    "$python"
    "[](fg:#86BBD8 bg:#06969A)"
    "$docker_context"
    "$nix_shell"
    "[](fg:#06969A bg:#33658A)"
    "$time"
    "$battery"
    "[ ](fg:#33658A)"
    "$status"
    "$line_break"
    "$shell"
       ];

    status = {
    style = "bg:transparent";
    symbol = "💀";
    success_symbol = "😅";
    format = ''[$symbol$common_meaning$signal_name$maybe_int]($style) '';
    map_symbol = true;
    disabled = false;
    };

    c = {
    symbol = "";
    style = "bg:#86BBD8";
    format = "[ $symbol ($version) ]($style)";
    };

    docker_context = {
    symbol = " ";
    style = "bg:#06969A";
    format = "[ $symbol $context ]($style) $path";
    };

    git_branch = {
    symbol = "";
    style = "bg:#FCA17D";
    format = "[ $symbol $branch ]($style)";
    };

    git_status = {
    style = "bg:#FCA17D";
    format = "[$all_status$ahead_behind ]($style)";
    };

    golang = {
    symbol = " ";
    style = "bg:#86BBD8";
    format = "[ $symbol($version) ]($style)";
    };

    haskell = {
    symbol = " ";
    style = "bg:#86BBD8";
    format = "[ $symbol($version) ]($style)";
    };

    java = {
    symbol = " ";
    style = "bg:#86BBD8";
    format = "[ $symbol($version) ]($style)";
    };

    nodejs = {
    symbol = " ";
    style = "bg:#86BBD8";
    format = "[ $symbol($version) ]($style)";
    };

    rust = {
    symbol = " ";
    style = "bg:#86BBD8";
    format = "[ $symbol($version) ]($style)";
    };
    python = {
        style = "bg:#86BBD8";
        format = "[ $symbol($version) ]($style)";
    };

    shell = {
    fish_indicator = ">";
    powershell_indicator = "_";
    unknown_indicator = "mystery shell";
    style = "cyan bold";
    disabled = false;
    };

    nix_shell = {
      disabled = false;
    style = "bg:#06969A";
      impure_msg = "[!pure](fg:bold blue $style)";
      pure_msg = "[pure](fg:bold green $style)";
      format = ''[ $symbol$state(\($name\))]($style)'';
    };
    sudo = {
        style = "bg:#9A348E";
        symbol = "👑 ";
        disabled = false;
        format = "[$symbol]($style)";
    };

    time = {
    disabled = false;
    #time_format = "%I:%M%p %a %h-%e"; # Hour:Minute Format
    time_format = "%I:%M%p"; # Hour:Minute Format
    style = "bg:#33658A";
    format = "[ $time ]($style)";
    };
    add_newline = true;
    battery = {
        full_symbol = "🔋";
        charging_symbol = "⚡";
        discharging_symbol = "🪫";
        format = "[$percentage$symbol]($style)";
        display = [
        {
        threshold = 90;
         style = "bg:#33658A";
        }
        ];
    };


  };
}
