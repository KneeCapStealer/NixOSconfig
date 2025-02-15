{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: with lib; let
    cfg = config.desktopEnvironments.hyprland;
  in  {
  options.desktopEnvironments.hyprland = {
    enable = mkEnableOption "hyprland desktop environment";
    package = mkPackageOption pkgs "hyprland" {
      pkgsText = literalExpression "pkgs";
    };

    portalPackage = mkPackageOption pkgs "xdg-desktop-portal-hyprland" {
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

    nixpkgs.overlays = [ inputs.hyprland-git.overlays.default ];

    environment.systemPackages = with pkgs; [
      hyprshot
      wl-clipboard
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
