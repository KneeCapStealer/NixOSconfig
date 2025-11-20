{
  config,
  pkgs,
  host,
  inputs,
  ...
}:

{
  imports = [
    ./langs/default.nix
  ];

  nixpkgs.config.segger-jlink.acceptLicense = true;
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    nrf-command-line-tools
    python313Packages.west
    vscode
    segger-jlink
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "segger-jlink-qt4-874"
  ];

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
  };
}
