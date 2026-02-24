{
  imports = [
    ./nvidia.nix
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;
    cpu.x86.msr.enable = true;

    enableAllFirmware = true;
    enableAllHardware = true;
    enableRedistributableFirmware = true;
  };
  services.fwupd.enable = true;

  powerManagement.enable = true;
  services.tlp.enable = true;
  services.upower.enable = true;

  services.systembus-notify.enable = true;

  services.libinput.enable = true;
}
