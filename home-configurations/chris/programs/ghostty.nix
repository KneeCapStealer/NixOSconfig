{
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    font-size = 12;
    background-opacity = 0.8;
    background-opacity-cells = true;
    background-blur = true;
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
