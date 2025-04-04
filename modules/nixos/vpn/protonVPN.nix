{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;

  cfg = config.services.protonVPN;
in
{
  options.services.protonVPN = {
    enable = mkEnableOption "protonVPN via wireguard";

    router.defaultRoute = mkOption {
      type = types.str;
      example = "192.168.1.1 dev eno1";
      description = ''
        The default route to your router.
        This is needed to setup a route for wireguard to the vpn.
        Can be found using: `ip route`;
      '';
    };

    interface = {
      name = mkOption {
        type = types.str;
        default = "protonVPN";
        example = "wg0";
        description = ''
          The name of the interface.
          This doesn't matter and is only for the user.
        '';
      };
      privateKeyFile = mkOption {
        type = types.path;
        example = "/root/secrets/protonvpn-privatekey";
        description = ''
          The path where your private key is located.
          This file should be kept secret under the root user.
        '';
      };
      address = mkOption {
        type = types.str;
        example = "10.2.0.2/32";
        description = ''
          The address of the interface.
        '';
      };
      port = mkOption {
        type = types.port;
        default = 51820;
        example = 51820;
        description = ''
          The listenport of the interface.
          If left null, wireguard will automaticly generate it.
        '';
      };

      dns = {
        enable = mkEnableOption "the protonVPN dns service";
        address = mkOption {
          type = types.str;
          default = "10.2.0.1";
          example = "10.2.0.1";
          description = ''
            The dns ip address to use for proton VPN.
          '';
        };
      };

      peer = {
        publicKey = mkOption {
          type = types.str;
          example = "sb*****************************************=";
          description = ''
            The public key of the peer;
          '';
        };
        endpoint = {
          address = mkOption {
            type = types.str;
            example = "48.1.3.4";
            description = ''
              The ip address of the endpoint;
            '';
          };
          port = mkOption {
            type = types.port;
            default = 51820;
            example = 51820;
            description = ''
              The ip address of the endpoint;
            '';
          };
        };
      };
    };
  };

  config =
    let
      interface = cfg.interface;
      peer = interface.peer;
    in
    mkIf cfg.enable {
      networking.wireguard.interfaces.${interface.name} = {
        ips = [ interface.address ];
        listenPort = interface.port;
        privateKeyFile = interface.privateKeyFile;
        peers = [
          {
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
            endpoint = with peer.endpoint; "${address}:${builtins.toString port}";
            publicKey = peer.publicKey;
            persistentKeepalive = 25;
          }
        ];
      };

      networking.dhcpcd.runHook = ''
        ${pkgs.iproute2}/bin/ip route add ${peer.endpoint.address}/32 via ${cfg.router.defaultRoute}
      '';
    };
}
