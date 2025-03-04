{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.gaming;
  mkEnableOptionDefaultTrue =
    name:
    (mkEnableOption name)
    // {
      default = true;
      defaultText = literalExpression "true";
    };
in
{
  options.gaming = {
    enable = mkEnableOption "gaming utilities such as steam and gamemode";
    steam = {
      enable = mkEnableOptionDefaultTrue "steam";
      package = mkPackageOption pkgs "steam" { };

      openFirewalls = mkEnableOptionDefaultTrue "opening steam multiplayer firewall ports." // {
        description = ''
          Enable this option to support hosting local LAN servers, and dedicated servers
          for your steam games.

          This option is also used for steam remote play.
        '';
      };

      protontricks = {
        enable = mkEnableOptionDefaultTrue "steam protontricks";
        package = mkPackageOption pkgs "protontricks" { };
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.gamemode.enable = true;
      programs.gamemode.enableRenice = true;
    }

    (mkIf cfg.steam.enable {
      hardware.steam-hardware.enable = true;
      programs.steam = {
        enable = true;
        inherit (cfg.steam) package;

        dedicatedServer.openFirewall = cfg.steam.openFirewalls;
        localNetworkGameTransfers.openFirewall = cfg.steam.openFirewalls;
        remotePlay.openFirewall = cfg.steam.openFirewalls;

        extest.enable = true;
        gamescopeSession.enable = true;

        protontricks = mkIf cfg.steam.protontricks.enable {
          inherit (cfg.steam.protontricks) enable package;
        };
      };
    })
  ]);
}
