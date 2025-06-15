{ config, pkgs, ... }:
{
  services.hardware.openrgb = { 
    enable = true; 
    package = pkgs.openrgb_git; 
    motherboard = "amd"; 
    server.port = 6742; 
  };

  hardware.i2c.enable = true;

  systemd.user.services.enable-openrgb-default-profile = {
    description = "Starts the 'default' profile of openrgb";
    path = [ config.services.hardware.openrgb.package ];
    script = ''
      #!/usr/bin/env sh

      openrgb -p default
    '';

    wantedBy = [ "default.target" ];
  };
}
