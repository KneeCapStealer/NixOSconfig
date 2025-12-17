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

      max-jobs = 6;
      cores = 16;
    };

    package = pkgs.nixVersions.latest;
  };

  programs.nix-ld.enable = true;
  services.envfs.enable = true;
}
