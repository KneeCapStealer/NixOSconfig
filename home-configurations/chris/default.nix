{
  self,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./dev
    ./hyprland
    ./programs
    ./gaming
    ./scripts

    inputs.catppuccin.homeModules.catppuccin
  ];

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";

  # My (VEERY thorough) ricing v2.0: HomeManager EDITION!!
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "peach";
  catppuccin.cursors.enable = true;

  programs.firefox.enable = true;
  # Orelse error happens :(
  programs.firefox.profiles.default.extensions.force = true;

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

  home.packages = with pkgs; [
    self.packages.x86_64-linux.glfw3-minecraft-wayland
    heroic
    activate-linux
    fastfetch
    discord
    btop-rocm
    spotify
    inputs.zen-browser.packages."${system}".default
    tor-browser
    qbittorrent-enhanced
    proton-pass
    prismlauncher
    furmark
    compsize
    parsec-bin
  ];

  home.sessionVariables = {
    BROWSER = "zen";
  };
}
