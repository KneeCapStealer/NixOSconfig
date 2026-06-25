{
  services.displayManager = {
    sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      wayland.compositor = "kwin";
    };
  };
}
