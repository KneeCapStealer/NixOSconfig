{ pkgs, ... }:
{
  imports = [ ./chris.nix ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  security.sudo.enable = false;
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true;
    execWheelOnly = true;
  };
}
