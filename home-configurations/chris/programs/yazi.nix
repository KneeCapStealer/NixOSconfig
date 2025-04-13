{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "H" ];
          run = "hidden toggle";
          desc = "Toggle visibility of hidden files";
        }
      ];
    };
  };

  home.sessionVariables = {
    FILEMANAGER = "yazi";
  };
}
