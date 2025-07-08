{ inputs, ...}:
{
  imports = [
    ./rofi.nix
    ./kitty.nix
    ./yazi.nix
    ./mpv.nix
    ./zsh.nix
    ./nvim.nix
    ./qt.nix
    ./gtk.nix

    ./eww
    (import ./quickshell { inherit inputs; })
  ];
}
