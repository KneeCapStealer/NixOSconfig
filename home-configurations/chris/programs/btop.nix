{ pkgs, host, ... }:
{
  programs.btop = {
    enable = true;
    package =
      with pkgs;
      if host == "desktop" then
        btop-rocm
      else if host == "laptop" then
        btop-cuda
      else
        btop;

  };
}
