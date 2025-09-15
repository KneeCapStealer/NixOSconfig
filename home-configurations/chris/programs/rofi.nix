{
  pkgs,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    font = "JetBrainsMono Nerd Font Medium 12";

    plugins = with pkgs; [
      rofi-games
      rofi-calc
      rofi-vpn
      rofi-emoji
    ];

    yoffset = 180;
  };
}
