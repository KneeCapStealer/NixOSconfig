{ config, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [
      "nvidia"
      "modesetting"
    ];
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    GBM_BACKEND = "nvidia-drm";
  };

  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    nvidiaSettings = false;
    videoAcceleration = true;
    modesetting.enable = true;
    powerManagement.enable = true;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      sync.enable = true;
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
