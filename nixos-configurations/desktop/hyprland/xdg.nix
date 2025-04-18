{ config, pkgs, ... }:
{
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
}
