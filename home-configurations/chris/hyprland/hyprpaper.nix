{ pkgs, host, ... }:
{
  services.hyprpaper =
    let
      src = pkgs.fetchFromGitHub {
        owner = "zhichaoh";
        repo = "catppuccin-wallpapers";
        rev = "1023077979591cdeca76aae94e0359da1707a60e";
        sha256 = "0rd6hfd88bsprjg68saxxlgf2c2lv1ldyr6a8i7m4lgg6nahbrw7";
      };
      wallpaperPath = src + "/landscapes/Cloudsday.jpg";
    in
    {
      enable = true;
      settings = {
        ipc = false;
        splash = true;
        preload = wallpaperPath;
        wallpaper = if host == "desktop" then [
          "DP-1,${wallpaperPath}"
          "HDMI-A-1,${wallpaperPath}"
        ] else if host == "laptop" then [
          "eDP-1,${wallpaperPath}"
        ] else "";
      };
    };
}
