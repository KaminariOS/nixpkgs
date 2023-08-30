pkgs:
let
  rustcli = with pkgs; [
    tealdeer
    zoxide
    tokei
    procs
    gitui
    sd
    bandwhich
    hexyl
    atuin
    broot
    delta
    ripgrep # fast grep
    # ripgrep-all

    navi # cheatsheet
    skim

    bottom # alternative to htop & ytop
    du-dust # disk usage/free utility
    exa # a better `ls`
    fd # "find" for files
    hyperfine # command-line benchmarking tool
    # File manager
    xplr
    # Port scanner
    rustscan
    grex # A command-line tool for generating regular expressions from user-provided test cases
    pstree

    # This is choose, a human-friendly and fast alternative to cut and (sometimes) awk
    choose
    # dog is a command-line DNS client.
    dog
    # dua (-> Disk Usage Analyzer) is a tool to conveniently learn about the usage of disk space of a given directory. It's parallel by default and will max out your SSD, providing relevant information as fast as possible. Optionally delete superfluous data, and do so more quickly than rm.
    dua
    # Efficient duplicate file finder and remover
    fclones
    htmlq
    jless
    jql
    miniserve

    # CLI tool for saving web pages as a single HTML file
    monolith
    # ouch stands for Obvious Unified Compression Helper.
    ouch
    # pastel is a command-line tool to generate, analyze, convert and manipulate colors. It supports many different color formats and color spaces like RGB (sRGB), HSL, CIELAB, CIELCh as well as ANSI 8-bit and 24-bit representations.
    pastel
    # Pipr is a commandline pipe-building tool, written in Rust!
    pipr

    #rip
    rargs
    xcp
    kalker
    # fend is an arbitrary-precision unit-aware calculator.
    # > 5'10" to cm
    # 177.8 cm
    fend
    # systeroid — A more powerful alternative to sysctl(8).
    systeroid
    # Like df
    lfs

  ];

  cargoAddons = with pkgs; [
    cargo-audit
    cargo-feature
    cargo-readme
    cargo-geiger
    cargo-msrv
    cargo-expand
    cargo-bloat
    cargo-flamegraph
    cargo-license
    cargo-supply-chain
    cargo-hack
    cargo-deny
    cargo-llvm-lines
    cargo-outdated
    cargo-udeps
  ];

  nixAddons = with pkgs; [
    any-nix-shell
    nix-diff
    nix-tree
    nix-du
    nix-prefetch-git
    # Run unpatched binaries on Nix/NixOS easily.
    manix
    statix
    # Comma runs software without installing it.
    comma
    cachix # nix caching
  ];

  lsps = with pkgs; [
    rnix-lsp # nix lsp server
    rust-analyzer
    gopls
    haskell-language-server
    # java-language-server
    texlab
    taplo-lsp # A TOML toolkit written in Rust
    # sumneko-lua-language-server
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.bash-language-server
    nodePackages.svelte-language-server
    jdt-language-server
    marksman
    #   wgsl_analyzer
    #python-lsp-server
    cmake-language-server
    code-minimap
  ];

  defaultShell = with pkgs; [
    xclip
    killall # kill processes by name
    ranger # terminal file explorer
    direnv

    clang-tools
    fortune
    ccls

    #An implementation of the Debug Adapter Protocol for Python 
    python310Packages.debugpy

    prettyping # a nicer ping
    xsel # clipboard support (also for neovim)

    zip
    unzip


    gnumake
    cmake
    gcc
    gdb
    #rust-gdb
    lldb
    evcxr

    python3
    iftop

    taskwarrior
    taskwarrior-tui

    file


    gh
    sshfs

    nyancat # the famous rainbow cat!
    rclone
    # Postgres cli
    pgcli

    xpra

    pandoc
    texlive.combined.scheme-small
  ];
in
defaultShell ++ rustcli ++ cargoAddons ++ nixAddons ++ lsps
