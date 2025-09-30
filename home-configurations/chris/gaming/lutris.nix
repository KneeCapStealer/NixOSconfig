{ pkgs, osConfig, ... }:
{
  programs.lutris = {
    enable = true;
    defaultWinePackage = pkgs.proton-ge-custom; # From chaotic-nyx
    protonPackages = with pkgs; [
      proton-ge-custom
    ];
    steamPackage = osConfig.programs.steam.package;
  };
}
