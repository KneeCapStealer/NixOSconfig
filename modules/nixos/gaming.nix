{ config, lib, pkgs, ...}:
let
  cfg = config.gaming;
  mkEnableTrue = name: lib.mkOption {
    default = true;
    example = false;
    description = "Wether to enable ${name}";
    type = lib.types.bool;
  };
in
{
  options.gaming = {
    enable = lib.mkEnableOption "Gaming utilities such as steam and gamemode";

    steam = {
      enable = mkEnableTrue "steam";

      package = lib.mkPackageOption pkgs "steam" {};

      openFirewalls = lib.mkOption {
        type = lib.types.bool;
        default = true;
        defaultText = lib.literalExpression "true";
        description = "Open steam firewall ports for multiplayer hosting purposes";
      };

      protontricks = {
        enable = mkEnableTrue "steam protontricks";

        package = lib.mkPackageOption pkgs "protontricks" {};
       };
    };
  };

  config = lib.mkIf cfg.enable {
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
  };
}
