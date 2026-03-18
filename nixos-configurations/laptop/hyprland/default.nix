{ inputs, pkgs, ... }:
{
  imports = [
    inputs.hyprland.nixosModules.default
    ./environment.nix
    ./xdg.nix
    ./gdm.nix
  ];

  programs.hyprland =
    let
      hyprPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      # withUWSM = true;
      package = hyprPkgs.hyprland;
      portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
    };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
