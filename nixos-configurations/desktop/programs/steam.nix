{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;

    extest.enable = true;
    gamescopeSession = {
      enable = true;
    };
    extraCompatPackages = with pkgs; [
      proton-ge-custom
    ];
  };

  programs.gamemode.enable = true;
  programs.gamemode.enableRenice = true;

  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope_git;
    capSysNice = true;
    args = [
      "--hdr-enabled"
    ];
  };
}
