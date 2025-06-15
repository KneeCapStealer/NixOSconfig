{ pkgs, ... }:
{
  environment = {
    sessionVariables = {
      # Good uwsm default settings:
      UWSM_USE_SESSION_SLICE = "true";
      UWSM_APP_UNIT_TYPE = "service";

      # wayland qt settings
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      GDK_BACKEND = "wayland,x11,*";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";

      NIXOS_OZONE_WL = 1;
    };
    systemPackages = with pkgs; [
      hyprshot
      wl-clipboard
      swaynotificationcenter
    ];
  };
}
