{ configsPath, ...}:
{
  programs.eww = {
    enable = true;
    configDir = configsPath + "/eww";
  };
}
