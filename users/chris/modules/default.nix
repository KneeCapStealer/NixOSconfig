{ configsPath, ... }:
{
  imports = [
    (import ./widgets/eww/default.nix { inherit configsPath; })
    ./desktop/hyprland
    ./programs
    ./gaming
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion = {
      enable = true;
    };

    defaultKeymap = "viins";
    dotDir = ".config/zsh";

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
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos#desktop -L";
    };
  };
}
