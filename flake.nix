{
  description = "A collection of my nixos configurations and the modules I use";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-git.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    addUser = name: module: {
      home-manager.useUserPackages = true;
      home-manager.useGlobalPkgs = true;

      home-manager.extraSpecialArgs = { inherit inputs; };
      home-manager.users.${name} = import module;
    };
  in {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/desktop/configuration.nix
        home-manager.nixosModules.default
        (addUser "chris" ./users/chris/home.nix)

        # Custom modules
        self.nixosModules.gaming
        self.nixosModules.graphics
        self.nixosModules.hyprland
      ];
    };

    nixosModules = {
      gaming = ./modules/nixos/gaming.nix;
      graphics = ./modules/nixos/graphics.nix;
      hyprland = ./modules/nixos/desktopEnvironments/hyprland.nix;
    };
  };
}
