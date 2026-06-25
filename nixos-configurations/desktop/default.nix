{ pkgs, ... }:
{
  _class = "nixos";

  imports = [
    ./catppuccin

    ./users
    ./hyprland
    ./hardware
    ./programs

    ./nix.nix
    ./boot.nix
    ./bluetooth.nix
    ./sound.nix
    ./danish.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];

  documentation.dev.enable = true;
  virtualisation.podman.enable = true;

  services.dbus = {
    enable = true;
    implementation = "broker";
  };

  qt.enable = true;

  services.openssh.enable = true;

  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";

    package = pkgs.scx.rustscheds;
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
        "datacow"
        "noatime"
        "autodefrag"
      ];
    in
    {
      "/".options = default;
      "/nix".options = default;
      "/home".options = [
        "nodatacow"
        "noatime"
        "autodefrag"
      ];
    };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.udisks2.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    zip
    unzip
    zstd
    xz
    gzip
    wget
    curl
  ];

  system.stateVersion = "25.05";
}
