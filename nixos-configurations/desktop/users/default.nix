{ pkgs, ... }:
{
  imports = [ ./chris.nix ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    trashy
  ];

  programs.zsh.shellAliases = {
    rm = "trash put";
    rmlist = "trash list";
    unrm = "trash restore";
  };

  security.sudo.enable = false;
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true;
    execWheelOnly = true;
  };
}
