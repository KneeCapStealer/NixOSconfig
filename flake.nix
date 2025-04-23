{
  description = "My personal NixOS configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    ez-configs.url = "github:ehllie/ez-configs";
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.ez-configs.flakeModule
        inputs.home-manager.flakeModules.home-manager
        inputs.nixvim.flakeModules.default
      ];
      systems = [ "x86_64-linux" ];

      flake.nixvimModules.default = ./nixvim;

      perSystem =
        { system, pkgs, ... }:
        {
          # You can define actual Nixvim configurations here
          nixvimConfigurations = {
            nixvim = inputs.nixvim.lib.evalNixvim {
              inherit system;
              modules = [
                self.nixvimModules.default
              ];
            };
          };

          packages = {
            glfw3-minecraft-wayland = pkgs.callPackage ./packages/glfw3-minecraft-wayland { };
            vulkan-hdr-layer = pkgs.callPackage ./packages/vulkan-hdr-layer { };
          };

          formatter = pkgs.nixfmt-rfc-style;
        };

      ezConfigs.root = ./.;
      ezConfigs.globalArgs = { inherit inputs self; };
      ezConfigs.nixos.hosts = {
        desktop.userHomeModules = [ "chris" ];
      };

      nixvim = {
        # Automatically install corresponding packages for each nixvimConfiguration
        # Lets you run `nix run .#<name>`, or simply `nix run` if you have a default
        packages.enable = true;
        # Automatically install checks for each nixvimConfiguration
        # Run `nix flake check` to verify that your config is not broken
        checks.enable = true;
      };
    };
}
