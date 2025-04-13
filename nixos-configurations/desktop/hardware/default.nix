{
  imports = [
    ./nvidia.nix
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;
    cpu.x86.msr.enable = true;

    ksm.enable = true;
    enableAllFirmware = true;
    enableAllHardware = true;
    enableRedistributableFirmware = true;
  };
}
