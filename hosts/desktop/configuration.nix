{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./partitionSettings.nix

    # YOU SHALL NOT PASS!!
    ./shooNOLOOK/tooTemptingValue.nix
  ];

  # Flake compatibility
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;
  users.users.chris = {
    isNormalUser = true;
    description = "Christoffer Hald Christensen";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "usb" "input" "disk" ];
    shell = pkgs.zsh;
  };

  # My (VEERY thorough) ricing
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "maroon";

  desktopEnvironments.hyprland.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  custom.boot.grub.enable = true;
  services.displayManager = {
    defaultSession = "hyprland-uwsm";
    sddm = {
      enable             = true;
      autoNumlock        = true;
      wayland.enable     = true;
      wayland.compositor = "weston";

      package = pkgs.kdePackages.sddm;
    };
  };
  
  languages.danish.enable = true;

  gaming.enable = true;
  graphics.nvidia.enable = true;
  graphics.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.enableAllFirmware = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.proxy.noProxy = "127.0.0.1,localhost";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Sound shit
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true; no flakes :'(
}
