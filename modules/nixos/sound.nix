{
  config,
  lib,
  ...
}: with lib; let
  cfg = config.sound;
in {
  options.sound = {
    enable = mkEnableOption "enable pipewire through the custom sound module by KneeCapStealer (GitHub)";
  };

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
