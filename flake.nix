{
  description = "A collection of my nixos configurations and the modules I use";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-git.url = "github:hyprwm/Hyprland";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    ...
  } @ inputs: 
  {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/desktop/configuration.nix
        {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;

          home-manager.extraSpecialArgs = { inherit inputs; configsPath = ./configs; };
          home-manager.users.chris = import ./users/chris/home.nix;
        }

        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.default
      ] ++ builtins.attrValues self.nixosModules;
    };

    nixosModules = {
      gaming = ./modules/nixos/gaming.nix;
      graphics = ./modules/nixos/graphics.nix;
      hyprland = ./modules/nixos/desktopEnvironments/hyprland.nix;
      languages = ./modules/nixos/languages/default.nix;
      boot = ./modules/nixos/boot.nix;
      sound = ./modules/nixos/sound.nix;
    };
  };
}
