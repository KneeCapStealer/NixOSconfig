{ pkgs, ... }:
{
  imports = [
    ./mangohud.nix
  ];

  home.packages = [
    pkgs.heroic
  ];
}
