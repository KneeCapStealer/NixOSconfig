{
  description = "My personal NixOS configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    ez-configs.url = "github:KneeCapStealer/ez-configs";
    catppuccin.url = "github:catppuccin/nix";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";

    nixvim.url = "github:nix-community/nixvim";

    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
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
        inputs.git-hooks-nix.flakeModule
      ];
      systems = [ "x86_64-linux" ];

      flake.nixvimModules.default = ./nixvim;

      flake.templates = {
        devShell = {
          path = ./templates/devShell;
          description = "A simple devshell for any project";
          welcomeText = ''
            # Simple devshell template
            go to flake.nix to add packages to the devShell.
            And write: `echo use flake >> .envrc && direnv allow`, to enable the shell via direnv.
          '';
        };
      };

      perSystem =
        {
          system,
          pkgs,
          config,
          ...
        }:
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
            nvim-unity = pkgs.callPackage ./packages/nvim-unity { };
            msi-271qpx-e2-icc = pkgs.callPackage ./packages/msi-271qpx-e2-icc { };
          };

          formatter = pkgs.nixfmt;
          pre-commit.settings.hooks.nixfmt.enable = true;

          devShells.default = pkgs.mkShell {
            inherit (config.pre-commit.settings) shellHook;
          };
        };

      ezConfigs.root = ./.;
      ezConfigs.globalArgs = { inherit inputs self; };

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
