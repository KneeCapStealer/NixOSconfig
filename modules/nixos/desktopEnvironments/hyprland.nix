{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: with lib; let
    cfg = config.desktopEnvironments.hyprland;
    hyprland-gitPackages = inputs.hyprland-git.packages.${pkgs.stdenv.hostPlatform.system};
  in  {
  options.desktopEnvironments.hyprland = {
    enable = mkEnableOption "hyprland desktop environment";
    package = mkPackageOption hyprland-gitPackages "hyprland" {
      pkgsText = literalExpression "inputs.hyprland-git.packages.${pkgs.stdenv.hostPlatform.system}";
    };

    portalPackage = if cfg.package == hyprland-gitPackages.hyprland
                    then mkPackageOption hyprland-gitPackages "xdg-desktop-portal-hyprland" {
                      pkgsText = literalExpression "inputs.hyprland-git.packages.${pkgs.stdenv.hostPlatform.system}";
                    }
                    else mkPackageOption pkgs "xdg-desktop-portal-hyprland" {
                      pkgsText = literalExpression "pkgs";
                    };

    withUWSM = mkEnableOption ''
      uwsm for hyprland, for better integration with systemd
    '' // {
      default = true;
      defaultText = literalExpression "true";
    };
  };
  
  config = mkIf cfg.enable {
    programs.hyprland = {
      inherit (cfg) enable package portalPackage withUWSM;
    };

    environment.systemPackages = with pkgs; [
      hyprshot
    ];

    # Good uwsm default settings:
    environment.sessionVariables = {
      UWSM_USE_SESSION_SLICE = "true";
      UWSM_APP_UNIT_TYPE = "service";
    };

    # Download hyprland instead of compiling it
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };
}
