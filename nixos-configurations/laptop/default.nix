{ pkgs, ... }:
{
  imports = [
    ./catppuccin

    ./chaotic
    ./users
    ./hyprland
    ./hardware
    ./programs

    ./nix.nix
    ./boot.nix
    ./bluetooth.nix
    ./home-manager.nix
    ./sound.nix
    ./danish.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./printing.nix
  ];

  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";

    package = pkgs.scx_git.rustscheds;
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs.nerd-fonts; [
      fira-code
      noto
    ];
  };

  fileSystems =
    let
      default = [
        "compress=zstd"
        "noatime"
      ];
    in
    {
      "/".options = default;
      "/home".options = default;
      "/nix".options = default;
    };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.sessionVariables = {
    GPG_TTY = "$(tty)";
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  system.stateVersion = "25.05";
}
