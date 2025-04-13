{ pkgs, ... }:
{
  nix = {
    settings.experimental-features = [
      "flakes"
      "nix-command"
    ];
    settings.system-features = [ "gccarch-x86-64-v3" ];
    
    trustedUsers = [ "root" "@wheel" ];

    package = pkgs.nixVersions.latest;
  };
}
