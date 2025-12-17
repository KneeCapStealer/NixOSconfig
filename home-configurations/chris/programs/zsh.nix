{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion = {
      enable = true;
    };

    defaultKeymap = "viins";
    dotDir = config.xdg.configHome + "/zsh";

    oh-my-zsh = {
      enable = true;
      theme = "awesomepanda";
      plugins = [
        "git"
      ];
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "brackets"
        "main"
      ];
    };

    shellAliases = {
      vim = "nvim";
      v = "nvim";
      vimdiff = "nvim -d";
      gs = "git status";
      nd = "nix develop";
    };
  };
}
