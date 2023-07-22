{
  description = "Home Manager configuration of Kosumi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    #nixpkgs.url = "nixpkgs/nixos-22.05";
    #nixpkgs.url = "github:NixOS/nixpkgs/e913ad8b17d40a12d982384372f387b63f3b5812";

    nurpkgs.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homeage = {
      url = "github:jordanisaacs/homeage?ref=323037e";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-nautilus-gtk3.url = "github:NixOS/nixpkgs?ref=37bd398";

    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    rycee-nurpkgs = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
      # url = "github:notashelf/neovim-flake";
      url = "github:KaminariOS/neovim-flake/dev";
      # neovim-flake pushes its binaries to the cache using its own nixpkgs version
      # if we instead use ours, we'd be rebuilding all plugins from scratch
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Fish shell

    fish-bobthefish-theme = {
      url = "github:gvolpe/theme-bobthefish";
      flake = false;
    };

    fish-keytool-completions = {
      url = "github:ckipp01/keytool-fish-completions";
      flake = false;
    };

    # Github Markdown ToC generator

    gh-md-toc = {
      url = "github:ekalinin/github-markdown-toc";
      flake = false;
    };

    # LaTeX stuff

    tex2nix = {
      #url = github:Mic92/tex2nix;
      url = "github:gvolpe/tex2nix"; # fork with nixFlakes fix
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      homeConfigurations = import ./outputs/home-conf.nix {
        inherit inputs system;
      };

      nixosConfigurations = import ./outputs/nixos-conf.nix {
        inherit inputs system;
      };
    };
}
