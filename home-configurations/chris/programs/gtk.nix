{
  pkgs,
  config,
  lib,
  ...
}:
{
  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "catppuccin-mocha-peach-compact";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "peach" ];
        variant = "mocha";
        size = "compact";
      };
    };
    iconTheme = lib.mkForce {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
  };

  xdg.configFile = {
    "gtk-4.0/assets".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  home.sessionVariables.GTK_THEME = config.gtk.theme.name;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      catppuccin-fcitx5
    ];
    fcitx5.settings.inputMethod = {
      "Groups/0" = {
        Name = "Default";
        "Default Layout" = "dk";
        "DefaultIM" = "keyboard-dk";
      };
      "Groups/0/Items/0" = {
        Name = "keyboard-dk";
        Layout = "";
      };

      GroupOrder."0" = "Default";
    };
  };
}
