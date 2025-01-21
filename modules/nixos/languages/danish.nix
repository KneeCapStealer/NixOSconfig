{
  config,
  lib,
  ...
}: with lib; let
  cfg = config.languages.danish;
  mkEnableOptionDefaultTrue = name: (mkEnableOption name) // {
    default = true;
    defaultText = literalExpression "true";
  };
in {
  options.languages.danish = {
    enable = mkEnableOption "the danish language";
    enableTimeZone = mkEnableOptionDefaultTrue "the danish time zone";
    enableKeymappings = mkEnableOptionDefaultTrue "the danish keyboard layout";
    systemLanguage = mkOption rec {
      default = "english";
      defaultText = default;
      example = "danish";
      type = types.strMatching "^(danish|english)$";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      # Select internationalisation properties.
      i18n.defaultLocale = 
        if cfg.systemLanguage == "english"
        then "en_DK.UTF-8"
        # The given type only accepts "english" or "danish"
        else "da_DK.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS        = "da_DK.UTF-8";
        LC_IDENTIFICATION = "da_DK.UTF-8";
        LC_MEASUREMENT    = "da_DK.UTF-8";
        LC_MONETARY       = "da_DK.UTF-8";
        LC_NAME           = "da_DK.UTF-8";
        LC_NUMERIC        = "da_DK.UTF-8";
        LC_PAPER          = "da_DK.UTF-8";
        LC_TELEPHONE      = "da_DK.UTF-8";
        LC_TIME           = "da_DK.UTF-8";
      };
    })

    (mkIf cfg.enableTimeZone {
      time.timeZone = "Europe/Copenhagen";
      time.hardwareClockInLocalTime = true;
    })

    (mkIf cfg.enableKeymappings {
      services.xserver.xkb = {
        layout = "dk";
        variant = "nodeadkeys";
      };

      console.keyMap = "dk-latin1";
    })
  ];
}
