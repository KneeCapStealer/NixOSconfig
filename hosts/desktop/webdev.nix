{
  pkgs,
  ...
}: {
  services.httpd.enable = true;
  services.httpd.enablePHP = true; # oof... not a great idea in my opinion
  services.httpd.phpPackage = pkgs.php82;

  services.httpd.virtualHosts."partytrackr.local" = {
    documentRoot = "/home/chris/dev/www/PartyTrackr";
    # want ssl + a let's encrypt certificate? add `forceSSL = true;` right here
  };

  programs.npm.enable = true;
  programs.npm.package = pkgs.nodePackages_latest.npm;

  environment.systemPackages = with pkgs; [
    nodePackages_latest.npm
    php82Packages.composer
  ];
}
