{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.graphics;
  enabledVendors = builtins.foldl' (
    enabled: vendor: enabled ++ (optional cfg.${vendor}.enable "nvidia")
  ) [ ] (builtins.attrNames cfg);
in
{
  options.graphics = {
    nvidia = {
      enable = mkEnableOption "nvidia drivers";
      package = mkOption {
        type = types.either types.package (
          types.enum [
            "stable"
            "beta"
            "production"
          ]
        );
        default = "stable";
        example = concatStrings [
          (literalExpression "\"beta\"")
          " or "
          (literalExpression "config.boot.kernelPackages.nvidiaPackages.beta")
        ];
        description = "Control the version of the nvidia drivers to be installed";
      };
      open = mkEnableOption "open source drivers for nvidia";
    };
  };

  config = mkMerge [
    {
      assertions = [
        {
          assertion = (length enabledVendors) < 2;
          message = "No more than two (2) graphics vendors may be enabled at once";
        }
      ];
    }

    (mkIf (elem "nvidia" enabledVendors) {
      services.xserver.enable = true;
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.enableAllFirmware = true;
      hardware.enableAllHardware = true;
      hardware.enableRedistributableFirmware = true;
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      hardware.nvidia = {
        inherit (cfg.nvidia) open;
        modesetting.enable = true;
        videoAcceleration = true;
        powerManagement.enable = true;

        package =
          if builtins.isString cfg.nvidia.package then
            config.boot.kernelPackages.nvidiaPackages.${cfg.nvidia.package} # option is the enum
          else
            cfg.nvidia.package; # option is the package
      };
    })
  ];
}
