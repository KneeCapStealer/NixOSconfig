{
  config,
  pkgs,
  lib,
  ...
}: with lib; {
  options.gaming = {
    enable = mkEnableOption "gaming utilities such as steam and gamemode";

    steam = {
      enable = mkEnableOption "steam";

      package = mkPackageOption pkgs "steam" {};

      openFirewalls = mkOption {
        type = types.bool;
        default = true;
        defaultText = literalExpression "true";
        description = "Open steam firewall ports for multiplayer hosting purposes";
      };

      protontricks = {
        enable = mkEnableOption "steam protontricks";

        package = mkPackageOption pkgs "protontricks" {};
       };
    };
  };

  config = let
    cfg = config.gaming;
  in mkMerge [
    # Default options
    {
      gaming.steam.enable = mkOptionDefault true;
      gaming.steam.protontricks.enable = mkOptionDefault true;
    }

    (mkIf cfg.enable {
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
    })
  ];
}
