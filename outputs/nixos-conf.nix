{
  inputs,
  system,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  savior = nixosSystem {
    inherit system;
    specialArgs = {inherit inputs;};
    modules = [
      ../system/machine/savior
      ../system/configuration.nix
    ];
  };

  portable = nixosSystem {
    inherit system;
    specialArgs = {inherit inputs;};
    modules = [
      ../system/machine/portable
      ../system/configuration.nix
    ];
  };
}
