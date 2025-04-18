{
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font Mono";
      package = pkgs.nerd-fonts.fira-code;
      size = 12;
    };
    settings = {
      confirm_os_window_close = 0;
    };
  };

  environment.sessionVariables = {
    TERMINAL = "kitty";
  };
}
