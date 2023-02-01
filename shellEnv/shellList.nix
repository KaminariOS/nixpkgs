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
    navi # cheatsheet
    skim

    bottom # alternative to htop & ytop
    du-dust # disk usage/free utility
    exa # a better `ls`
    fd # "find" for files
    hyperfine # command-line benchmarking tool
    ripgrep-all
    xplr
    rustscan
    grex # A command-line tool for generating regular expressions from user-provided test cases
    pstree
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
    #    wgsl_analyzer
    #  nodePackages_latest.yaml-language-server
    python-language-server
    cmake-language-server

    fortune

    prettyping           # a nicer ping
    xsel                 # clipboard support (also for neovim)

    zip 
    unzip


    gnumake
    cmake
    gcc

    python
  ];
  in
  (defaultShell ++ rustcli)
