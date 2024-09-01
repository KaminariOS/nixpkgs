{lib, ...}: let
  inherit (lib) mkDefault;
in {
  programs.starship.settings = {
    aws.symbol = mkDefault " ";
    battery = {
      full_symbol = mkDefault " ";
      charging_symbol = mkDefault " ";
      discharging_symbol = mkDefault " ";
      unknown_symbol = mkDefault "󰂑";
      empty_symbol = mkDefault " ";
    };
    cmake.symbol = mkDefault " ";
    conda.symbol = mkDefault " ";
    crystal.symbol = mkDefault " ";
    dart.symbol = mkDefault " ";
    directory.read_only = mkDefault " 💿";
    docker_context.symbol = mkDefault " ";
    dotnet.symbol = mkDefault " ";
    elixir.symbol = mkDefault " ";
    elm.symbol = mkDefault " ";
    erlang.symbol = mkDefault " ";
    gcloud.symbol = mkDefault " ";
    git_branch.symbol = mkDefault " ";
    git_commit.tag_symbol = mkDefault " ";
    git_status = {
      format = mkDefault "([$all_status$ahead_behind]($style) )";
      conflicted = mkDefault "⚔️ ";
      ahead = mkDefault "📤";
      behind = mkDefault "📥";
      diverged = mkDefault " ";
      untracked = mkDefault "❔";
      stashed = mkDefault "📚 ";
      modified = mkDefault "✒️ ";
      staged = mkDefault "💾";
      renamed = mkDefault " ";
      deleted = mkDefault "🗑️";
    };
    golang.symbol = mkDefault " ";
    helm.symbol = mkDefault "⎈ ";
    hg_branch.symbol = mkDefault " ";
    java.symbol = mkDefault " ";
    julia.symbol = mkDefault " ";
    kotlin.symbol = mkDefault " ";
    kubernetes.symbol = mkDefault "☸ ";
    lua.symbol = mkDefault " ";
    memory_usage.symbol = mkDefault "󰍛 ";
    nim.symbol = mkDefault " ";
    nix_shell.symbol = mkDefault " ";
    nodejs.symbol = mkDefault "󰎙 ";
    openstack.symbol = mkDefault " ";
    package.symbol = mkDefault "📦";
    perl.symbol = mkDefault " ";
    php.symbol = mkDefault " ";
    scala.symbol = mkDefault " ";
    purescript.symbol = mkDefault "<≡>";
    python.symbol = mkDefault " ";
    ruby.symbol = mkDefault " ";
    rust.symbol = mkDefault " ";
    shlvl.symbol = mkDefault " ";
    status = {
      symbol = mkDefault " ";
      not_executable_symbol = mkDefault " ";
      not_found_symbol = mkDefault " ";
      sigint_symbol = mkDefault " ";
      signal_symbol = mkDefault " ";
    };
    swift.symbol = mkDefault " ";
    terraform.symbol = mkDefault "󱁢 ";
    vagrant.symbol = mkDefault "𝗩 ";
    zig.symbol = mkDefault " ";
  };
}
