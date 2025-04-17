{ pkgs, ...}:
{
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    
    extest.enable = true;
    gamescopeSession = {
      enable = true;
      args = [
        "--hdr-enabled"
	"--expose-wayland"
	"--immediate-flips"
      ];
    };
    extraCompatPackages = with pkgs; [
      proton-ge-custom
    ];
  };
}
