{
  config,
  pkgs,
  lib,
  ...
}: with lib; {
  options.gaming = {
    enable = mkEnableOption "gaming utilities such as steam and gamemode";

    steam = {
      enable = mkEnableOption "steam"
      // {
        default = true;
        defaultText = literalExpression "true";
      };

      package = mkPackageOption pkgs "steam" { };

      openFirewalls = mkEnableOption "opening steam multiplayer firewall ports."
      // {
        default = true;
        defaultText = literalExpression "true";
        description = ''
          Enable this option to support hosting local LAN servers, and dedicated servers
          for your steam games.

          This option is also used for steam remote play.
        '';
      };

      protontricks = {
        enable = mkEnableOption "steam protontricks"
        // {
          default = true;
          defaultText = literalExpression "true";
        };

        package = mkPackageOption pkgs "protontricks" { };
       };
    };
  };

  config = let
    cfg = config.gaming;
  in mkIf cfg.enable {
      programs.gamemode.enable = true;
      programs.gamemode.enableRenice = true;
      hardware.steam-hardware.enable = mkIf cfg.steam.enable true;

      programs.steam = mkIf cfg.steam.enable {
        inherit (cfg.steam) enable package;

        dedicatedServer.openFirewall = cfg.steam.openFirewalls;
        localNetworkGameTransfers.openFirewall = cfg.steam.openFirewalls;
        remotePlay.openFirewall = cfg.steam.openFirewalls;

        extest.enable = true;
        gamescopeSession.enable = true;

        protontricks = mkIf cfg.steam.protontricks.enable {
          inherit (cfg.steam.protontricks) enable package;
        };
      };
    };
}
