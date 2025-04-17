{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    package = pkgs.pipewire;
    audio.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    wireplumber.package = pkgs.wireplumber;
  };
}
