{ pkgs, ... }:

{
  imports = [
    ./web.nix
    ./langs/default.nix
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Christoffer Hald Christensen";
    userEmail = "chrishald@proton.me";

    aliases = {
      amend = "commit --amend -a";
      b = "branch";
    };

    signing.key = "28803B602DA4F5BE";
    signing.signByDefault = true;

    extraConfig = {
      color = {
        ui = "auto";
      };
      merge = {
        tool = "nvimdiff";
        conflictstyle = "diff3";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      diff = {
        tool = "nvimdiff";
        mnemonicprefix = true;
      };
    };
  };
}
