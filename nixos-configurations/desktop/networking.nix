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

    router.defaultRoute = "192.168.1.1 dev eno1";
    interface = {
      privateKeyFile = "/root/secrets/protonVPNDenmark.key";
      address = "10.2.0.2/32";

      peer = {
        publicKey = "9WowgFUh2itRfPh2SoaJsJHvxzXBZuD+xqdmBAf2CB4=";
        endpoint.address = "149.50.217.161";
      };
    };
  };
}
