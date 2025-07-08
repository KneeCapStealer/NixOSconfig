{ inputs, ... }:
{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.x86_64-linux.default;
    activeConfig = "taskbar";
    systemd.enable = true;
    configs = {
      taskbar = ./taskbar;
    };
  };
}
