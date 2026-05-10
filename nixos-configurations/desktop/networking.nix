{
  ezModules,
  pkgs,
  ...
}:
{
  imports = [
    ezModules.protonVPN
    ezModules.nextDNS
  ];

  networking.nftables.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  services.openvpn.servers = {
    pia = {
      config = "config /root/secrets/pia_openvpn.ovpn";
      autoStart = false;
    };
  };

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

}
