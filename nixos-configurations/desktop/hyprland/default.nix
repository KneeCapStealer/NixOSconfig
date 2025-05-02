{ inputs, ... }:
{
  imports = [
    inputs.hyprland.nixosModules.default
    ./environment.nix
    ./xdg.nix
    ./sddm.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.x86_64-linux.hyprland;
    portalPackage = inputs.hyprland.packages.x86_64-linux.xdg-desktop-portal-hyprland;
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
