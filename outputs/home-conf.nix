{ inputs, system, ... }:

with inputs;

let
  fishOverlay = f: p: {
    inherit fish-bobthefish-theme fish-keytool-completions;
  };

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;

    overlays = [
      fishOverlay
      nurpkgs.overlay
      neovim-flake.overlays.default
      (f: p: { tex2nix = tex2nix.defaultPackage.${system}; })
      ((import ../home/overlays/md-toc) { inherit (inputs) gh-md-toc; })
      (import ../home/overlays/ranger)
    ];
  };

  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };

  imports = [
    homeage.homeManagerModules.homeage
    neovim-flake.nixosModules.hm
    ../home/home.nix
  ];

  mkHome = { hidpi ? false }: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs;

      extraSpecialArgs = {
        inherit hidpi;
        addons = nur.repos.rycee.firefox-addons;
      };

      modules = [{ inherit imports; }];
    }
  );
in
{
  kosumi = mkHome { hidpi = false; };
  kaminari = mkHome { hidpi = true; };

  # Continuos Integration automation
#  ci = {
#    metals = pkgs.callPackage ../home/programs/neovim-ide/metals.nix { };
#    metals-updater = pkgs.callPackage ../home/programs/neovim-ide/update-metals.nix { };
#  };
}
