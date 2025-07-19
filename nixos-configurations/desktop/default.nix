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
    ./home-manager.nix
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

  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    zip
    unzip
    zstd
    xz
    gzip
    wget
    curl
    inputs.quickshell.packages.x86_64-linux.default
  ];

  system.stateVersion = "25.05";

  systemd.user.services.enable-numlock-on-startup = {
    description = "Enabled numlock when logging in";
    path = [ pkgs.kbd ];
    script = ''
      #!/usr/bin/env sh

      # Enable numlock for each tty
      for tty in /dev/tty{1..7}
      do
          setleds -D +num < "$tty";
      done
    '';

    wantedBy = [ "default.target" ];

  };
}
