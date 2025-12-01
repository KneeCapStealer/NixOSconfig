{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      c
      nix
      bash
      json
      lua
      zig
      cpp
      markdown
      vimdoc
      vim
      glsl
      qmljs
      haskell
    ];

    settings = {
      highlight.enable = true;
      additional_vim_regex_highlighting = false;
    };
  };
}
