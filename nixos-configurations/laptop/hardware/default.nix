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

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "schedutil";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
