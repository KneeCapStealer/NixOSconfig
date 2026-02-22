{ lib, ... }:
{
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    font-size = 12;
    font-family = "FiraCode Nerd Font Mono";

    background-opacity = 0.95;
    background-opacity-cells = true;
    background-blur = true;
  };

  xdg.terminal-exec = {
    enable = true;
    settings.default = lib.singleton "com.mitchellh.ghostty.desktop";
  };

  # home.sessionVariables = {
  #   TERMINAL = "ghostty";
  # };
}
