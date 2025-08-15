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
    dotDir =  config.xdg.configHome + "/zsh";

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
      movie = "ENABLE_GAMESCOPE_WSI=1 gamescope --hdr-enabled --expose-wayland -H 1440 -h 1440 -W 2560 -w 2560 -r 240 -- mpv --target-colorspace-hint --gpu-api=vulkan --gpu-context=waylandvk --fs";
      vim = "nvim";
      vimdiff = "nvim -d";
    };
  };
}
