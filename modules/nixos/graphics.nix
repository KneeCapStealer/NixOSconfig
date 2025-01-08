{
  config,
  lib,
  ...
}: with lib; {
  options.graphics = {
    vendors.nvidia = {
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

  config = let
    cfg = config.graphics;
    vendors = cfg.vendors;
    enabledVendors = foldl
      (enabled: vendor: enabled ++ (optional vendors.${vendor}.enable "nvidia"))
      []
      (builtins.attrNames vendors);

    # Merge configs for each vendor
    in mkMerge [
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
