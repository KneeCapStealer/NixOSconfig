{ self, ... }:
{
  home.packages = [
    self.packages.x86_64-linux.nixvim
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
