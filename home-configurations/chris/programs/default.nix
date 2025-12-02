args:
{
  imports = [
    (import ./btop.nix args)
    (import ./zen.nix args)
    ./foot.nix
    # ./rofi.nix
    # ./kitty.nix
    ./yazi.nix
    ./mpv.nix
    ./zsh.nix
    ./nvim.nix
    ./qt.nix
    ./gtk.nix
    ./vesktop.nix
    ./nemo.nix
    ./ghostty.nix
    ./caelestia-shell.nix

    ./eww
  ];

  programs.obs-studio.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
  programs.less.enable = true;
}
