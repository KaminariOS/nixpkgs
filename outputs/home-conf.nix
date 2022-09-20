{ system, nixpkgs, home-manager, ... }:

let
  username = "kosumi";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.xdg.configHome = configHome;
    overlays = [ neovim-flake.overlays.default ];
  };


in
{
  imports = [
    homeage.homeManagerModules.homeage
    ../home.nix
  ];
  main = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs system username homeDirectory;
    modules = [{ inherit imports; }];
    configuration = import ./home.nix {
      inherit (pkgs) config lib stdenv;
    };
  };
}
