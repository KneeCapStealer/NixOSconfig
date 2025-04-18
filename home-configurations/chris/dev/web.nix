{ pkgs, ... }:

{
  imports = [
    ./langs/php.nix
  ];

  home.packages = with pkgs; [ beekeeper-studio ];
}
