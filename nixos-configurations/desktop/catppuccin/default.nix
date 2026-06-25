{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.nixosModules.default
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "peach";
    cache.enable = true;
  };
}
