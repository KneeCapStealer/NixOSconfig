{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.gaming = {
    enable = lib.mkEnableOption "gaming utilities such as steam and gamemode";

    steam = {
      enable = lib.mkEnableOption "steam";

      package = lib.mkPackageOption pkgs "steam" {};

      openFirewalls = lib.mkOption {
        type = lib.types.bool;
        default = true;
        defaultText = lib.literalExpression "true";
        description = "Open steam firewall ports for multiplayer hosting purposes";
      };

      protontricks = {
        enable = lib.mkEnableOption "steam protontricks";

        package = lib.mkPackageOption pkgs "protontricks" {};
       };
    };
  };

  config = let
    cfg = config.gaming;
  in
  lib.mkMerge [
    # Default options
    {
      gaming.steam.enable = lib.mkOptionDefault true;
      gaming.steam.protontricks.enable = lib.mkOptionDefault true;
    }

    (lib.mkIf cfg.enable {
      programs.gamemode.enable = true;
      programs.gamemode.enableRenice= true;

      programs.steam = lib.mkIf cfg.steam.enable {
        inherit (cfg.steam) enable package;

        dedicatedServer.openFirewall = cfg.steam.openFirewalls;
        localNetworkGameTransfers.openFirewall = cfg.steam.openFirewalls;
        remotePlay.openFirewall = cfg.steam.openFirewalls;

        extest.enable = true;
        gamescopeSession.enable = true;

        protontricks = lib.mkIf cfg.steam.protontricks.enable {
          inherit (cfg.steam.protontricks) enable package;
        };
      };
    })
  ];
}
