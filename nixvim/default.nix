{
  lib,
  ...
}:
let
  helpers = lib.nixvim;
in
{
  imports = [
    ./lsp

    ./cmp.nix
    ./mini.nix
    ./oil.nix
    ./treesitter.nix
    ./ufo.nix
    ./zig.nix
    ./debugging.nix
    ./telescope.nix
    ./leap.nix
    ./surround.nix
  ];

  plugins.nix.enable = true;
  clipboard.providers.wl-copy.enable = true;
  globals.mapleader = " ";

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavor = "mocha";
      integrations = {
        treesitter = true;
      };

      styles = {
        keywords = [ "italic" ];
      };
    };
  };

  dependencies.git.enable = true;

  globalOpts = {
    tabstop = 8;
    softtabstop = 0;
    shiftwidth = 4;
    smarttab = true;
    expandtab = true;

    scrolloff = 12;
    relativenumber = true;

    undofile = true;
    swapfile = false;
  };

  keymaps = let 
    centerCmd = cmd: {
      key = cmd;
      action = "${cmd}zz";
    };
  in (builtins.map centerCmd [
    "<C-d>"
    "<C-u>"
    "<C-f>"
    "<C-b>"
  ]) ++ [
    {
      key = "<C-u>";
      action = "<C-u>zz";
    }
    {
      mode = [ "n" ];
      key = "i";
      action = helpers.mkRaw ''
      function ()
        return vim.api.nvim_get_current_line():match('%g') == nil and 'cc' or 'i'
      end
      '';
      options = {
        expr = true;
        noremap = true;
        desc = "Enter insert mode, with correct indentation";
      };
    }
  ];
}
