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
      #neovim-flake.overlays.${system}.default
      (f: p: { tex2nix = tex2nix.defaultPackage.${system}; })
      ((import ../home/overlays/md-toc) { inherit (inputs) gh-md-toc; })
      (import ../home/overlays/ranger)
    ];
  };

  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };
  commonImports = [
    homeage.homeManagerModules.homeage
    neovim-flake.homeManagerModules.default
  ];

  #imports = [
  #../home/home.nix
  #] ++ commonImports;

  #shellImports = [
  #../shellEnv/home.nix
  #] ++ commonImports;

  mkHome = { hidpi ? false, username, shell ? false, homed }: (
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit hidpi;
        addons = nur.repos.rycee.firefox-addons;
      };

      modules = let homeDirectory = homed; in [
        { imports = commonImports ++ (if shell then [ ../shellEnv/home.nix ] else [ ../home/home.nix inputs.plasma-manager.homeManagerModules.plasma-manager ]); }
        {
          home = {
            inherit username;
            inherit homeDirectory;
          };
          programs.git.signing.signByDefault = !shell;
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
  kosumi = let username = "kosumi"; in mkHome { hidpi = false;inherit username; homed = "/home/${username}"; };

  shellhome = let username = "Kosumi"; in mkHome { hidpi = false;inherit username; shell = true; homed = "/users/${username}"; };
  # Continuos Integration automation
  #  ci = {
  #    metals = pkgs.callPackage ../home/programs/neovim-ide/metals.nix { };
  #    metals-updater = pkgs.callPackage ../home/programs/neovim-ide/update-metals.nix { };
  #  };
}
