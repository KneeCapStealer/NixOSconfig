{ inputs, pkgs, ... }:
    let
      src = pkgs.fetchFromGitHub {
        owner = "zhichaoh";
        repo = "catppuccin-wallpapers";
        rev = "1023077979591cdeca76aae94e0359da1707a60e";
        sha256 = "0rd6hfd88bsprjg68saxxlgf2c2lv1ldyr6a8i7m4lgg6nahbrw7";
      };
      wallpaperPath = src + "/landscapes";
    in
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia.enable = true;
  programs.caelestia.cli.enable = true;
  programs.caelestia.settings = {
    paths.wallpaperDir = wallpaperPath;
    background = {
      enabled = true;
      desktopClock.enabled = true;
    };
  };
}
