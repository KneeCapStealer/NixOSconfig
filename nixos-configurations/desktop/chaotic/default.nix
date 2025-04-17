{ inputs, ... }:
{
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  chaotic = {
    hdr.enable = true;
    hdr.specialisation.enable = false;
  };
}
