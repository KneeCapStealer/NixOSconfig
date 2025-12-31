{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    via
  ];

  hardware.keyboard.qmk.enable = true;

  services.udev.packages = with pkgs; [
    via
    qmk
    qmk_hid
  ];
}
