{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
      bash
      json
      lua
      php
      zig
      cpp
      markdown
      vimdoc
      vim
      glsl
      qmljs
    ];

    settings = {
      highlight.enable = true;
      additional_vim_regex_highlighting = false;
    };
  };
}
