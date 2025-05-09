{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.timeout = 3;
  boot.loader.efi.canTouchEfiVariables = true;
}
