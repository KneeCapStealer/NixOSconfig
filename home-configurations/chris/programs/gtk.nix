{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme.name = "Adwaita:dark";
  };

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
