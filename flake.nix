{
  description = "A collection of my nixos configurations and the modules I use";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/desktop/configuration.nix
        home-manager.nixosModules.default
        {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;

          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.chris = import ./users/chris/home.nix;
        }
      ];
    };
  };
}
