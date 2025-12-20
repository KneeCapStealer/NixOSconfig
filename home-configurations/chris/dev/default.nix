{
  config,
  pkgs,
  host,
  ...
}:

{
  imports = [
    ./langs/default.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      user = {
        name = "Christoffer Hald Christensen";
        email = "chrishald@proton.me";
      };

      alias = {
        amend = "commit --amend -a";
        b = "branch";
        yank = "pull";
        st = "status -sb";
        lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
        lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
        lg = "lg1";
      };

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
    signing.key =
      if host == "desktop" then
        "28803B602DA4F5BE"
      else if host == "laptop" then
        "8384C1918B58E2BB"
      else
        null;

    signing.signByDefault = config.programs.git.signing.key != null;

    ignores = [
      ".envrc"
      ".direnv/"
    ];
  };
}
