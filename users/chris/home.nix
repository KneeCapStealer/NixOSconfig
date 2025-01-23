{
  inputs,
  pkgs,
  configsPath,
  ...
}: {
  imports = [
    (import ./modules/default.nix { inherit configsPath; })
    ./modules/dev/default.nix

    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  # My (VEERY thorough) ricing v2.0: HomeManager EDITION!!
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "maroon";

  home.packages = with pkgs; [
    activate-linux
    fastfetch
    vesktop
    (btop.override { cudaSupport = true; })
    spotify
    inputs.zen-browser.packages."${system}".specific
    tor-browser
    qbittorrent-enhanced
    proton-pass
    dolphin
    haruna
    protonup
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 12;
    };
    settings = {
      confirm_os_window_close = 0;
    };
  };
}
