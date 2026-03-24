{ pkgs, ... }:
{
  i18n = {
    defaultLocale = "en_DK.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "da";
      LC_MESSAGES = "en_DK.UTF-8";
      # LC_ALL = "da_DK.UTF-8"; # This overrides all other LC_* settings.
      LC_CTYPE = "da_DK.UTF-8";
      LC_ADDRESS = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
      LC_COLLATE = "da_DK.UTF-8";
    };
    extraLocales = [ "all" ];
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        ignoreUserConfig = true;
        addons = with pkgs; [
          fcitx5-gtk
          catppuccin-fcitx5
        ];

        settings.inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "dk";
          };
          "Groups/0/Items/0".Name = "keyboard-dk";
        };
      };
    };
  };
  environment.sessionVariables.QT_IM_MODULES = "wayland;fcitx;ibus";

  time.timeZone = "Europe/Copenhagen";

  services.xserver.xkb = {
    layout = "dk";
  };

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
    # prevents `systemd-vconsole-setup` failing during systemd initrd
    earlySetup = true;
  };
  systemd.services.systemd-vconsole-setup.unitConfig.After = "local-fs.target";

  boot.initrd = {
    enable = true;
    systemd.enable = true;
  };
}
