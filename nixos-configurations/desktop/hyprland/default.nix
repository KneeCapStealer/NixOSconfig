{ inputs, ... }:
{
  imports = [
    inputs.hyprland.nixosModules.default
    ./environment.nix
    ./xdg.nix
    ./sddm.nix
  ];

  nixpkgs.overlays = [
    inputs.hyprland.overlays.default
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
