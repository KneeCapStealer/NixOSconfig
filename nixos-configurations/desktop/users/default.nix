{ pkgs, ... }:
{
  imports = [ ./chris.nix ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
