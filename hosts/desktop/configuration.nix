{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./partitionSettings.nix
    # ./webdev.nix
    ../commonOptions

    # YOU SHALL NOT PASS!!
    ./shooNOLOOK/tooTemptingValue.nix
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.1.5"
  ];

  # Flake compatibility
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.system-features = [
    "benchmark"
    "big-parallel"
    "kvm"
    "nixos-test"
    "gccarch-skylake"
  ];

  nix.package = pkgs.nixVersions.latest;
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  users.users.chris = {
    isNormalUser = true;
    description = "Christoffer Hald Christensen";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "usb"
      "input"
      "disk"
    ];
    homeMode = "755";
    shell = pkgs.zsh;
  };

  # dns
  dns.nextDNS = {
    enable = true;
    endpointId = "f8ac75";
    deviceName = "Chris--Desktop";
  };

  services.protonVPN = {
    enable = true;

    router.defaultRoute = "192.168.1.1 dev eno1";
    interface = {
      privateKeyFile = "/root/secrets/protonVPNDenmark.key";
      address = "10.2.0.2/32";

      peer = {
        publicKey = "9WowgFUh2itRfPh2SoaJsJHvxzXBZuD+xqdmBAf2CB4=";
        endpoint.address = "149.50.217.161";
      };
    };
  };

  # My (VEERY thorough) ricing
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "maroon";

  desktopEnvironments.hyprland.enable = true;
  programs.hyprlock.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_6_12;
  custom.boot.grub.enable = true;
  services.displayManager = {
    sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      wayland.compositor = "weston";

      package = pkgs.kdePackages.sddm;
    };
  };

  languages.danish.enable = true;

  gaming.enable = true;
  graphics.nvidia.enable = true;
  graphics.nvidia.package = "stable";
  hardware.enableAllFirmware = true;

  networking.hostName = "chris-desktop"; # Define your hostname.
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
    wireplumber.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true; no flakes :'(
}
