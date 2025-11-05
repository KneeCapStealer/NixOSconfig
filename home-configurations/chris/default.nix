{
  self,
  inputs,
  pkgs,
  lib,
  host,
  ...
}@args:
{
  imports = [
    (import ./dev args)
    (import ./programs args)
    (import ./hyprland args)
    ./gaming
    ./scripts

    inputs.catppuccin.homeModules.catppuccin
    inputs.chaotic.homeManagerModules.default
  ];

  nix.package = pkgs.nixVersions.latest;

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";

  # My (VEERY thorough) ricing v2.0: HomeManager EDITION!!
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "peach";
  catppuccin.cursors.enable = true;

  # usb
  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
      };
    };
  };

  programs.obs-studio.enable = true;

  home.packages = with pkgs; [
    self.packages.x86_64-linux.glfw3-minecraft-wayland
    heroic
    activate-linux
    fastfetch
    discord
    spotify
    inputs.zen-browser.packages."${system}".default
    qbittorrent-enhanced
    proton-pass
    prismlauncher
    furmark
    compsize
    parsec-bin
    prusa-slicer
    networkmanagerapplet
    obsidian
  ];

  home.sessionVariables = {
    BROWSER = "zen";
  };
}
