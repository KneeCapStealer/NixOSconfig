{ config, lib, ... }:
let
  inherit (lib)
    mkOption
    mkEnableOption
    types
    mkIf
    defaultTo
    ;
  cfg = config.dns.nextDNS;
in
{
  options.dns.nextDNS = {
    enable = mkEnableOption "NextDNS via resolved";
    endpointId = mkOption {
      type = types.str;
      description = ''
        The id of your NextDNS profile.
        This number can be found in the 'setup' page of your profile.
      '';
      example = "f6bf88";
    };
    deviceName = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        The device name to be logged in NextDNS.
        Allowed characters are A-Z, a-z, 0-9, and -. Use -- for space character.
      '';
      example = "Jhon--Router";
    };
  };

  config = mkIf cfg.enable {
    networking.nameservers =
      let
        endpoint = "${cfg.endpointId}.dns.nextdns.io";
        deviceName = defaultTo config.networking.hostName cfg.deviceName;
      in
      map (ip: "${ip}#${deviceName}-${endpoint}") [
        "45.90.28.0"
        "2a07:a8c0::"
        "45.90.30.0"
        "2a07:a8c1::"
      ];

    services.resolved = {
      enable = true;
      dnsovertls = "true";
    };
  };
}
