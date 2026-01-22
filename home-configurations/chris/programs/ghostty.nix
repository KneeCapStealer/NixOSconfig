{
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    font-size = 12;
    font-family = "FiraCode Nerd Font Mono";

    background-opacity = 0.95;
    background-opacity-cells = true;
    background-blur = true;
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
