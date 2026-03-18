{ config, pkgs, ... }:
{
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    # If used with Firefox
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime-legacy1
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [
    "nvidia"
    "modesetting"
  ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    powerManagement.enable = true;

    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";

      offload.enable = false;
    };
  };

  programs.nix-required-mounts.enable = true;
  programs.nix-required-mounts.presets.nvidia-gpu.enable = true;
}
