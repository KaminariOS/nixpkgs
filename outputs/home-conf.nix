{ system, nixpkgs, home-manager, ... }:

let

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.xdg.configHome = configHome;
    overlays = [ neovim-flake.overlays.default ];
  };
  imports = [
    ../home.nix
  ];

in
{
   homeConfigurations.kaminari = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs system;
    username = "kaminari";
    modules = [{ inherit imports; }];
    configuration = import ../home.nix {
      inherit (pkgs) config lib stdenv pkgs;
    };
  };
  main = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs system ;
  username = "kosumi";
    # pkgs.config.xdg.configHome = configHome;
    modules = [{ inherit imports; }];
    configuration = import ./home.nix {
      inherit (pkgs) config lib stdenv pkgs;
    };
  };
}
