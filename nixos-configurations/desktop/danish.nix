{ pkgs, ... }:
{
  i18n = {
    defaultLocale = "en_DK.UTF-8";
    extraLocales = [ "da_DK.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
    };

    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        catppuccin-fcitx5
      ];
    };
  };
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
