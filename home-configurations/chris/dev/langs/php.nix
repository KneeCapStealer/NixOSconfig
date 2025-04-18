{ pkgs, ... }:
{
  home.packages = with pkgs; [
    php82
    php82Packages.php-cs-fixer
    phpactor
    laravel
  ];
}
