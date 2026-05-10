{
  ezModules,
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
    europe = {
      config = "config /root/secrets/openvpn/europe.ovpn ";
      autoStart = false;
    };
  };


}
