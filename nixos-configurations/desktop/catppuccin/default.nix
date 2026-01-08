{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.nixosModules.default
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "peach";
    cache.enable = true;
  };
}
