{ pkgs, ... }:
{
  imports = [
    ./catppuccin

    ./chaotic
    ./users
    ./hyprland
    ./hardware

    ./nix.nix
    ./boot.nix
    ./home-manager.nix
    ./sound.nix
    ./danish.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];

  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  services.scx.enable = true;
  services.scx.scheduler = "scx_lavd";

  fonts = {
    fontDir.enable = true;
    packages = with pkgs.nerd-fonts; [
      fira-code
      noto
    ];
  };

  fileSystems =
    let
      compress = "compress=zstd";
      nocompress = "compress=no";
      nocow = "nodatacow";

      default = [ compress ];
    in
    {
      "/".options = default;
      "/home".options = default;
      "/nix".options = default;
      "/tmp".options = default;
      "/var/log".options = default;
      "/var/cache".options = default;
      "/games".options = [
        nocompress
        nocow
      ];
    };

  system.stateVersion = "24.05";
}
