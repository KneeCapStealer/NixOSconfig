{ inputs, ... }:
{
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  chaotic = {
    hdr.enable = false;
  };
}
