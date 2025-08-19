{
  programs.quickshell = {
    enable = false;
    activeConfig = "taskbar";
    systemd.enable = true;
    configs = {
      taskbar = ./taskbar;
    };
  };
}
