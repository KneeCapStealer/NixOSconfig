{ host, lib, ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = lib.optionals (host == "laptop") [
        # lock screen after 2 minutes
        {
          timeout = 1200;
          on-timeout = "caelestia shell lock lock";
        }
        # turn off screen after 5 minutes
        {
          timeout = 30000;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # turn off screen after 10 minutes
        {
          timeout = 60000;
          on-timeout = "systemctl suspend";
        }
      ];

    };
  };

  programs.hyprlock.enable = true;
}
