{ pkgs, osConfig, ... }:
{
  # programs.lutris = {
  #   enable = true;
  #   defaultWinePackage = pkgs.proton-ge-bin; # From chaotic-nyx
  #   protonPackages = with pkgs; [
  #     proton-ge-bin
  #   ];
  #   steamPackage = osConfig.programs.steam.package;
  # };

  home.packages = [ pkgs.lutris ];
}
