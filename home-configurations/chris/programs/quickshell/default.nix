{
  programs.quickshell = {
    enable = true;
    activeConfig = "taskbar";
    systemd.enable = true;
    configs = {
      taskbar = ./taskbar;
    };
  };
}
