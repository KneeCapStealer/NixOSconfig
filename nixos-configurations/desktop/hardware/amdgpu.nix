{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libGL
      libGLU
      libGLX
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libGL
      libGLU
      libGLX
    ];
  };

  hardware.amdgpu.overdrive = {
    enable = true;
    ppfeaturemask = "0xffffffff";
  };

  hardware.amdgpu.opencl.enable = true;

  # overclocking
  services.lact.enable = true;
}
