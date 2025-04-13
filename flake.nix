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
  };

  outputs =
    inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.ez-configs.flakeModule
        inputs.home-manager.flakeModules.home-manager
      ];
      systems = [ "x86_64-linux" ];

      perSystem =
        { pkgs, ... }:
        {
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
    };
}
