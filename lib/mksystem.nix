{ nixpkgs, inputs, name }:

let
  machine = "thor";
in
nixpkgs.lib.nixosSystem {
  system = inputs.flake-utils.lib.system.x86_64-linux;
  specialArgs = {
    inherit inputs;
  };
  modules = [
  ];
}