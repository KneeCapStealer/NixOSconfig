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
    ./gaming

    inputs.catppuccin.homeModules.catppuccin
  ];

  nix.package = pkgs.nixVersions.latest;
  programs.home-manager.enable = true;

  services.gnome-keyring.enable = true;
  services.gnome-keyring.components = [ "ssh" ];

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
  catppuccin.autoEnable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "peach";
  catppuccin.cursors.enable = true;
  catppuccin.cache.enable = true;

  # usb
  services.udiskie = {
    enable = true;
    settings = {
      program_options.file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
    };
  };

  xdg.enable = true;
  xdg.autostart.enable = true;

  home.packages = with pkgs; [
    self.packages.x86_64-linux.glfw3-minecraft-wayland
    heroic
    activate-linux
    fastfetch
    spotify
    qbittorrent-enhanced
    furmark
    compsize
    prusa-slicer
    orca-slicer
    obsidian
    firefox
    ffmpeg
  ];
}
