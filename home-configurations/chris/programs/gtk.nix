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
  };
}
