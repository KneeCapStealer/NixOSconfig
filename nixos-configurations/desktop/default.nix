{ pkgs, inputs, ... }:
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
    ./sound.nix
    ./danish.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./printing.nix
  ];

  services.dbus = {
    enable = true;
    implementation = "broker";
  };

  qt.enable = true;

  services.openssh.enable = true;

  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  services.scx = {
    enable = true;
    scheduler = "scx_bpfland";

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

  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    zip
    unzip
    zstd
    xz
    gzip
    wget
    curl
  ];

  services.displayManager.sessionPackages = [
    inputs.river.packages.x86_64-linux.river
  ];

  system.stateVersion = "25.05";
}
