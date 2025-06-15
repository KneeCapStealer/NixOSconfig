{ pkgs, ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      wayland.compositor = "weston";

      package = pkgs.kdePackages.sddm;
    };
  };
}
