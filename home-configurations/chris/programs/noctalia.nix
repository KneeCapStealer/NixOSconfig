{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # screenshot and recording
    grim
    imagemagick

    # audio
    pwvucontrol
  ];

  programs.satty.enable = true;


  home.file."Pictures/Wallpapers" = {
    recursive = true;
    source = 
    let
      wallpaperSrc = pkgs.fetchFromGitHub {
        owner = "zhichaoh";
        repo = "catppuccin-wallpapers";
        rev = "1023077979591cdeca76aae94e0359da1707a60e";
        sha256 = "0rd6hfd88bsprjg68saxxlgf2c2lv1ldyr6a8i7m4lgg6nahbrw7";
      };
      wallpaperPath = wallpaperSrc + "/landscapes";
    in
    wallpaperPath;
  };
}

