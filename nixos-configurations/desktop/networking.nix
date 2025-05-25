{ ezModules, ... }:
{
  imports = [
    ezModules.protonVPN
    ezModules.nextDNS
  ];

  services.nextDNS = {
    enable = true;
    endpointId = "f8ac75";
    deviceName = "Chris--Desktop";
  };

  services.protonVPN = {
    enable = true;

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
