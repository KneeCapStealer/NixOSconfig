{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;

    gamescopeSession = {
      enable = true;
    };
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    extraPackages = with pkgs; [
      gtk4
      gtk3
      gtk3-x11
      gtk2
      gtk2-x11
      xwayland
      xwayland-run
    ];
  };

  programs.gamemode.enable = true;
  programs.gamemode.enableRenice = true;

  programs.gamescope = {
    enable = true;
    # capSysNice = true;
    args = [
      "--hdr-enabled"
    ];
  };

  # Possible increased performance and compatibility with windows games
  boot.kernelModules = [ "ntsync" ];
  environment.sessionVariables = {
    PROTON_USE_NTSYNC = 1;
    PROTON_ENABLE_WAYLAND = 1;
    PROTON_ENABLE_HDR = 1;
  };
}
