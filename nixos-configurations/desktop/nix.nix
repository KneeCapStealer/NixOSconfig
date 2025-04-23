{ pkgs, ... }:
{
  nix = {
    settings.experimental-features = [
      "flakes"
      "nix-command"
    ];
    settings.system-features = [ "gccarch-x86-64-v3" ];

    settings.trusted-users = [
      "root"
      "@wheel"
    ];

    package = pkgs.nixVersions.latest;
  };

  programs.nix-ld.enable = true;

  services.envfs.enable = true;
}
