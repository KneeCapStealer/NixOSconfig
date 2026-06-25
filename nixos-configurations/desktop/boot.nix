{
  _class = "nixos";

  boot.loader.limine = rec {
    enable = true;
    biosSupport = false;
    resolution = "2560x1440";
    style.interface.resolution = resolution;
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
