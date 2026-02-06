{
  programs.vesktop = {
    enable = true;
    vencord.useSystem = true;
    vencord.settings = {
      autoUpdate = false;
      autoUpdateNotification = false;
      notifyAboutUpdates = false;
      useQuickCss = true;
      disableMinSize = true;
      arRPC = true;
      plugins = {
        petpet.enabled = true;
      };
    };
  };
  services.arrpc.enable = true;
}
