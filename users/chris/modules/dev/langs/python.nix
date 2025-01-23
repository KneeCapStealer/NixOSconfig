{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python313Full
    python313FreeThreading
  ];
}
