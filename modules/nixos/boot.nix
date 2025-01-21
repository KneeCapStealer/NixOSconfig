{
  config,
  pkgs,
  lib,
  ...
}: with lib; let
  cfg = config.custom.boot;
in {
  options.custom.boot = {
    grub = {
      enable = mkEnableOption "the custom boot loader module by KneeCapStealer (GitHub) for grub";
      useOSProber = mkEnableOption "OS Prober for grub";
    };
    systemd-boot = {
      enable = mkEnableOption "the custom boot loader module by KneeCapStealer (GitHub) for systemd-boot";
      windows = mkOption {
        default = {};
        defaultText = literalExpression "{}";
        description = "Look at boot.loader.systemd-boot.windows for more information";
      };
    };
  };

  config = mkMerge [
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;
    }

    (mkIf cfg.grub.enable {
      boot.loader.grub = {
        inherit (cfg.grub) enable useOSProber;
        efiSupport = true;
      };
    })

    (mkIf cfg.systemd-boot.enable {
      boot.loader.systemd-boot = {
        inherit (cfg.systemd-boot) enable windows;
        editor = false;
      };
    })
  ];
}
