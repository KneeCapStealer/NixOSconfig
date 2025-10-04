{ pkgs, ... }:
{
  imports = [
    ./mangohud.nix
    ./lutris.nix
  ];

  home.packages = [
    pkgs.legendary-gl
    pkgs.rare
    pkgs.heroic
  ];
}
