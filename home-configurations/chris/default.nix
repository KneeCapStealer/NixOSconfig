{
  self,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./dev
    ./desktop/hyprland
    ./programs
    ./gaming
    ./scripts

    inputs.catppuccin.homeModules.catppuccin
    inputs.chaotic.homeModules.default
  ];

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  # My (VEERY thorough) ricing v2.0: HomeManager EDITION!!
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "maroon";
  catppuccin.cursors.enable = true;

  home.packages = with pkgs; [
    self.packages.x86_64-linux.glfw3-minecraft-wayland
    heroic
    # self.packages.x86_64-linux.vulkan-hdr-layer
    activate-linux
    fastfetch
    vesktop
    discord
    (btop.override { cudaSupport = true; })
    spotify
    inputs.zen-browser.packages."${system}".specific
    tor-browser
    qbittorrent-enhanced
    proton-pass
    haruna
    protonup
    neovim
    prismlauncher
    llvmPackages_latest.clang
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen";
  };
}
