{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.desktopEnvironments.hyprland;
in
{
  options.desktopEnvironments.hyprland = {
    enable = mkEnableOption "hyprland desktop environment";
    package = mkPackageOption pkgs "hyprland" { };

    portalPackage = mkPackageOption pkgs "xdg-desktop-portal-hyprland" { };

    withUWSM =
      mkEnableOption ''
        uwsm for hyprland, for better integration with systemd
      ''
      // {
        default = true;
        defaultText = literalExpression "true";
      };
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      inherit (cfg)
        enable
        package
        portalPackage
        withUWSM
        ;
      xwayland.enable = true;
    };

    programs.xwayland.enable = true;

    nixpkgs.overlays = [ inputs.hyprland-git.overlays.default ];

    environment.systemPackages = with pkgs; [
      hyprshot
      wl-clipboard
      swaynotificationcenter
    ];

    environment.sessionVariables = {
    # Good uwsm default settings:
      UWSM_USE_SESSION_SLICE = "true";
      UWSM_APP_UNIT_TYPE = "service";

      # wayland qt settings
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      GDK_BACKEND = "wayland,x11,*";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
    };

    # XDG desktop portal
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
      xdgOpenUsePortal = true;
    };

    environment.pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];

    # Download hyprland instead of compiling it
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };
}
