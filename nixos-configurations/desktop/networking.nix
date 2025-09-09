{ ezModules, pkgs, lib, ... }:
{
  imports = [
    ezModules.protonVPN
    ezModules.nextDNS
  ];


  networking.nftables.enable = true;
  networking.firewall.allowedUDPPorts = [ 67 68 69 80 ];
  networking.firewall.allowedTCPPorts = [ 67 68 69 80 ];

  services.atftpd = {
    enable = true;
    root = "/srv/tftp";
    extraOptions = [
      "--daemon"
      "--no-fork"
      "--no-timeout"
      "--logfile"
      "-"
    ];
  };

  networking.networkmanager = {
    enable = true;
  };

  services.nextDNS = {
    enable = true;
    endpointId = "f8ac75";
    deviceName = "Chris--Desktop";
  };

  services.protonVPN = {
    enable = false;

    router.defaultRoute = "192.168.1.1 dev enp8s0";
    interface = {
      privateKeyFile = "/root/secrets/protonVPN.key";
      address = "10.2.0.2/32";

      peer = {
        publicKey = "+6VseaiwdWLFSlaTgwafQM9D9DsT1aanqywtgf7XdC8=";
        endpoint.address = "185.111.109.1";
      };
    };
  };
}
