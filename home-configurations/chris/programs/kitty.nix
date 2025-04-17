{
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Fira Code Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
      size = 12;
    };
    settings = {
      confirm_os_window_close = 0;
    };
  };
}
