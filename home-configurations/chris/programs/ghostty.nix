{
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    font-size = 12;
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
