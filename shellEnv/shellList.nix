pkgs:
let rustcli = with pkgs; [
    nushell
    tealdeer
    zoxide
    tokei
    procs
    starship
    gitui
    sd
    bandwhich
    hexyl
    atuin
    broot
    delta
    helix
    ripgrep # fast grep
    # rga
    ripgrep-all

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
  ];

  defaultShell = with pkgs; [
    any-nix-shell
    xclip
    killall # kill processes by name
    ranger # terminal file explorer
    direnv

    rnix-lsp # nix lsp server
    rust-analyzer
    gopls
    haskell-language-server
    java-language-server
    texlab
    taplo-lsp # A TOML toolkit written in Rust
    sumneko-lua-language-server
    #   wgsl_analyzer
    #  nodePackages_latest.yaml-language-server
    #python-lsp-server
    cmake-language-server
    fortune

    prettyping           # a nicer ping
    xsel                 # clipboard support (also for neovim)

    zip 
    unzip


    gnumake
    cmake
    gcc
    gdb

    python3
    iftop

    nix-prefetch-git

    taskwarrior
    taskwarrior-tui

    file
    nix-diff
    nix-prefetch-git
    gh
    cachix
  ];
  in
  (defaultShell ++ rustcli)