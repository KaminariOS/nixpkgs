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
  redmoon = nixosSystem {
    inherit system;
    specialArgs = {inherit inputs;};
    modules = [
      ../system/machine/redmoon
      ../system/configuration.nix
    ];
  };
  thinker = nixosSystem {
    inherit system;
    specialArgs = {inherit inputs;};
    modules = [
      ../system/machine/thinker
      ../system/configuration.nix
    ];
  };
}
