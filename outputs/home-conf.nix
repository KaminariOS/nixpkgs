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
      neovim-flake.overlays.${system}.default
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
    neovim-flake.nixosModules.${system}.hm
    ../home/home.nix
  ];

  mkHome = { hidpi ? false, username }: (
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit hidpi;
        addons = nur.repos.rycee.firefox-addons;
      };

      modules = let homeDirectory = "/home/${username}"; in [
      { inherit imports; }
         {
          home = {
            inherit username;
            inherit homeDirectory; 
          };

          xdg = {
            configHome = "${homeDirectory}/.config";
            enable = true;
          };
        }
      ];
    }
  );
in
{
  kosumi = mkHome { hidpi = false; username = "kosumi";};
  kaminari = mkHome { hidpi = true; username = "kaminari";};

  # Continuos Integration automation
#  ci = {
#    metals = pkgs.callPackage ../home/programs/neovim-ide/metals.nix { };
#    metals-updater = pkgs.callPackage ../home/programs/neovim-ide/update-metals.nix { };
#  };
}
