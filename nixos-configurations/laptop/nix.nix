{ pkgs, ... }:
{
  nix = {
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];

      trusted-users = [
        "root"
        "@wheel"
      ];

      cores = 6;
      max-jobs = 4;
    };

    package = pkgs.nixVersions.latest;
  };

  programs.nh.enable = true;
  programs.nh.flake = "/home/chris/.config/nixos/";

  programs.nix-ld.enable = true;
  services.envfs.enable = true;
}
