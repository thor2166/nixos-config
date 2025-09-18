{
  description = "Valde's nixos configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, rofi-unicode-list, fenix, ... }@inputs:
    let
      system = flake-utils.lib.system.x86_64-linux;
      machine = "thor";
      mkSystem = name: import ./lib/mksystem.nix {
        inherit nixpkgs inputs name;
      };
    in
    {
      
      nixosConfigurations.home = mkSystem "home";
      
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
    };
}
