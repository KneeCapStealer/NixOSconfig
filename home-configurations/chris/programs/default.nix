{ host, pkgs, ... }:
{
  imports = [
    (import ./btop.nix { inherit pkgs host; })
    ./rofi.nix
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
    ./obsidian.nix

    ./eww
  ];
}
