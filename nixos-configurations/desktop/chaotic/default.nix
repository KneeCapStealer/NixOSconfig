{ inputs, ... }:
{
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  chaotic = {
    hdr.enable = true;
    mesa-git.enable = true;
  };
}
