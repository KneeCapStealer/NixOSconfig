{
  self,
  inputs,
  pkgs,
  osConfig,
  ...
}@args:
{
  imports = [
    (import ./dev args)
    (import ./programs args)
    (import ./hyprland args)
    ./gaming

    inputs.catppuccin.homeModules.catppuccin
  ];

  nix.package = pkgs.nixVersions.latest;
  programs.home-manager.enable = true;

  home = {
    username = "chris";
    homeDirectory = "/home/chris";
    stateVersion = osConfig.system.stateVersion;
    language.base = "en_DK";
    preferXdgDirectories = true;
    extraOutputsToInstall = [ "doc" ];
  };

  # My (VEERY thorough) ricing v2.0: HomeManager EDITION!!
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "peach";
  catppuccin.cursors.enable = true;
  catppuccin.cache.enable = true;

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

  xdg.autostart.enable = true;

  home.packages = with pkgs; [
    self.packages.x86_64-linux.glfw3-minecraft-wayland
    heroic
    activate-linux
    fastfetch
    discord
    spotify
    qbittorrent-enhanced
    proton-pass
    prismlauncher
    furmark
    compsize
    parsec-bin
    prusa-slicer
    orca-slicer
    networkmanagerapplet
    obsidian
    firefox
    ffmpeg
    eddie
  ];
}
