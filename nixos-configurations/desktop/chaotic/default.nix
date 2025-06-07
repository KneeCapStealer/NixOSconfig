{ inputs, pkgs, ... }:
{
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  chaotic = {
    mesa-git.enable = true;
    hdr.enable = true;
    hdr.specialisation.enable = false;
    hdr.wsiPackage = pkgs.gamescope-wsi_git;
  };
}
