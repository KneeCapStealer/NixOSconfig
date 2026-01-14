{
  pkgs,
  ...
}@args:
{
  imports = [
    (import ./btop.nix args)
    (import ./zen.nix args)
    ./caelestia-shell.nix
    ./direnv.nix
    ./foot.nix
    ./ghostty.nix
    ./gtk.nix
    ./libreoffice.nix
    ./mpv.nix
    ./nemo.nix
    ./nvim.nix
    ./qt.nix
    ./vesktop.nix
    ./yazi.nix
    ./zsh.nix

    ./eww
  ];

  programs.obs-studio.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
  programs.less.enable = true;
  programs.ripgrep.enable = true;

  home.packages = with pkgs; [
    google-chrome
    tor-browser
    easyeffects
  ];
}
