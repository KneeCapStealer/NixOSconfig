{
  pkgs,
  ...
}@args:
{
  imports = [
    (import ./btop.nix args)
    (import ./zen.nix args)
    ./direnv.nix
    ./element.nix
    ./ghostty.nix
    ./gtk.nix
    ./libreoffice.nix
    ./mpv.nix
    ./nemo.nix
    ./noctalia.nix
    ./nvim.nix
    ./qt.nix
    ./rofi.nix
    ./vesktop.nix
    ./yazi.nix
    ./zsh.nix
  ];

  programs.jq.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
  programs.less.enable = true;
  programs.ripgrep.enable = true;
  programs.obs-studio.enable = true;
  home.packages = with pkgs; [
    google-chrome
    tor-browser
    easyeffects
    nemo-with-extensions
    (pkgs.stoat-desktop.override {
      electron_38 = pkgs.electron;
    })
  ];
}
