{
  pkgs,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "JetBrainsMono Nerd Font Medium 12";

    plugins = with pkgs; [
      rofi-games
      rofi-calc
      rofi-vpn
      rofi-emoji-wayland
    ];

    yoffset = 180;
  };
}
