{ inputs, pkgs, ... }:
{
  # Home manager does this automatically

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      inputs.hyprland.packages.x86_64-linux.xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
    config = {
      hyprland.preferred = [ "hyprland" "gtk" ];
    };
  };

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];
}
