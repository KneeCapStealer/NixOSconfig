{ config, lib, ... }:
{
  programs.fzf.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion = {
      enable = true;
    };

    defaultKeymap = "viins";
    dotDir = config.xdg.configHome + "/zsh";

    initContent = 
    let 
      fzf = "source <(fzf --zsh)";
      lineedit = ''
        autoload -U edit-command-line
        zle -N edit-command-line
        bindkey "^xe" edit-command-line
        bindkey "^x^e" edit-command-line
      '';
    in lib.mkMerge [
      (lib.mkBefore fzf)
      (lib.mkAfter lineedit)
    ];



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
      nd = "nix develop";
    };
  };
}
