{ inputs, pkgs, ... }:
{
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  chaotic = {
    hdr.enable = true;
    hdr.specialisation.enable = false;
    hdr.wsiPackage = pkgs.gamescope-wsi_git;
  };
}
