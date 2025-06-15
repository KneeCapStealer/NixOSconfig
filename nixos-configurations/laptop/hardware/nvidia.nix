{ config, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    videoAcceleration = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true;
    prime.offload.enable = true;
  };
}
