{ pkgs, ... }:

{
  home.packages = with pkgs; [
    php
    phpactor
    laravel
  ];
}
