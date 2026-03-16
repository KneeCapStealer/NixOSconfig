{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # nix
    nixd 

    # rust
    clippy
    rustfmt
  ];
}
