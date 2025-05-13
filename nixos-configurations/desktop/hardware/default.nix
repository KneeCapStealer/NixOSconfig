{
  imports = [
    ./amdgpu.nix
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    cpu.x86.msr.enable = true;

    ksm.enable = true;
    enableAllFirmware = true;
    enableAllHardware = true;
    enableRedistributableFirmware = true;
  };
}
