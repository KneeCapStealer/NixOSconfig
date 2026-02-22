{ pkgs, self, ... }:
{
  home.packages = with pkgs; [
    unityhub
    self.packages.x86_64-linux.nvim-unity
  ];
}
