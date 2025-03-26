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

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self; };

        modules = [
          ./hosts/desktop/configuration.nix
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;

            home-manager.extraSpecialArgs = {
              inherit inputs self;
              configsPath = ./configs;
            };
            home-manager.users.chris = import ./users/chris/home.nix;
          }

          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.default
        ] ++ builtins.attrValues self.nixosModules;
      };

      packages.${system} = {
        glfw3-minecraft-wayland = (pkgs.callPackage ./packages/glfw3-minecraft-wayland/package.nix { });
      };

      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;

      nixosModules = {
        gaming = ./modules/nixos/gaming.nix;
        graphics = ./modules/nixos/graphics.nix;
        hyprland = ./modules/nixos/desktopEnvironments/hyprland.nix;
        languages = ./modules/nixos/languages/default.nix;
        boot = ./modules/nixos/boot.nix;
        dns = ./modules/nixos/dns;
        vpn = ./modules/nixos/vpn;
      };

      homeManagerModules = {
        catppuccinRanger = ./modules/home-manager/programs/ranger.nix;
      };
    };
}
