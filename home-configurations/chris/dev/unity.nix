{ pkgs, self, ... }:
{
  home.packages = with pkgs; [
    unityhub
    self.packages.x86_64-linux.nvim-unity
    dotnetCorePackages.sdk_10_0
  ];

  xdg.mimeApps =
    let
      unityhub = {
        "x-scheme-handler/unityhub" = "unityhub.desktop";
      };
    in
    {
      associations.added = unityhub;
      defaultApplications = unityhub;
    };
}
