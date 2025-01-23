{
  config,
  lib,
  ...
}: with lib; let
    cfg = config.graphics;
    enabledVendors = builtins.foldl'
      (enabled: vendor: enabled ++ (optional cfg.${vendor}.enable "nvidia"))
      []
      (builtins.attrNames cfg);

  in {
  options.graphics = {
    nvidia = {
      enable = mkEnableOption "nvidia drivers";
      package = mkPackageOption config.boot.kernelPackages.nvidiaPackages "nvidia drivers" {
        default = "stable";
        example = "beta";
        extraDescription = "Control the version of the nvidia drivers to be installed";
        pkgsText = literalExpression "config.boot.kernelPackages.nvidiaPackages";
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

        hardware.graphics = {
          enable = true;
          enable32Bit = true;
        };

        hardware.nvidia = {
          inherit (cfg.vendors.nvidia) package open;
          modesetting.enable = true;
          videoAcceleration = true;
          powerManagement.enable = true;
        };
      })
    ];
  }
