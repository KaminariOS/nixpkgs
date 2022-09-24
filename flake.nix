{
  description = "Home Manager configuration of Jane Doe";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixgl is needed for alacritty outside of nixOS
    # refer to https://github.com/NixOS/nixpkgs/issues/122671
    neovim-flake = {
        url = github:gvolpe/neovim-flake;
        inputs.nixpkgs.follows = "nixpkgs";
      };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fish-bobthefish-theme = {
      url = github:gvolpe/theme-bobthefish;
      flake = false;
    };

    fish-keytool-completions = {
      url = github:ckipp01/keytool-fish-completions;
      flake = false;
    };
  };

  outputs = inputs @ {self, nixpkgs, home-manager, neovim-flake, ... }:
    let
      system = "x86_64-linux";
      fishOverlay = with inputs; f: p: {
    inherit fish-bobthefish-theme fish-keytool-completions;
  };
      pkgs = nixpkgs.legacyPackages.${system};
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
       overlays = [
       fishOverlay
        inputs.neovim-flake.overlays.default
       ];
      };

    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      # homeConfigurations.kosumi = home-manager.lib.homeManagerConfiguration {
        # pkgs = pkgsForSystem system;
        # extraSpecialArgs = {
         # inherit hidpi;
        # };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        # modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      # };
   homeConfigurations.kosumi = let username = "kosumi"; in
  home-manager.lib.homeManagerConfiguration
   rec {
    pkgs = pkgsForSystem system;
    modules = [
    ./home.nix
     neovim-flake.nixosModules.hm
    {
    home = {
        inherit username;
            homeDirectory = "/home/${username}";
            stateVersion = "22.05";
          };
    }
    ];

  };

   homeConfigurations.kaminari = let username = "kaminari"; in
  home-manager.lib.homeManagerConfiguration
   rec {
    pkgs = pkgsForSystem system;
    modules = [
    ./home.nix
     neovim-flake.nixosModules.hm
    {
    home = {
        inherit username;
            homeDirectory = "/home/${username}";
            stateVersion = "22.05";
          };
    }
    ];

  };

    };
}
