{
  pkgs,
  ...
}:
{
  hardware.keyboard.qmk.enable = true;

  services.udev.packages = with pkgs; [
    via
    qmk
    qmk_hid
  ];
}
