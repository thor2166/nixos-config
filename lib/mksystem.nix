{ nixpkgs, inputs, name }:

let machine = "thor";
in nixpkgs.lib.nixosSystem {
  system = inputs.flake-utils.lib.system.x86_64-linux;
  specialArgs = { inherit inputs; };
  modules = [
    ../system/machine/${name}
    inputs.home-manager.nixosModules.home-manager
    ({ pkgs, lib, config, ... }@deps: {
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = [
        pkgs.gh
        pkgs.vscode
        pkgs.git
        pkgs.vesktop
        pkgs.alsa-utils
        pkgs.alsa-tools
        pkgs.pciutils
        pkgs.spotify
      ];
      programs.firefox.enable = true;
        users.users.${machine} = {
          shell = pkgs.zsh;
        };
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
      home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${machine} = {
            home.stateVersion = "25.05";
            home.username = "${machine}";
            home.homeDirectory = "/home/${machine}";
            programs.home-manager.enable = true;
             programs.fzf = {
              enable = true;
              enableZshIntegration = true;
            };
                        programs.zsh = {
              enable = true;
              oh-my-zsh = {
                enable = true;
                theme = "agnoster";
                plugins = [ "git" ];
              };
              initExtra  = ''
              source <(${pkgs.fzf}/bin/fzf --zsh)
              '';
            };
          };
        };
    })
  ];
}
