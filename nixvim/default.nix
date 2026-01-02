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

  keymaps =
    let
      genkeymaps =
        mode: keys: f:
        let
          defaultkeymaps = builtins.map (key: {
            inherit mode key;
            action = key;
          }) keys;
        in
        builtins.map (kmap: kmap // f kmap) defaultkeymaps;

    in
    # center after scrolling
    (genkeymaps
      [ "n" "v" ]
      [
        "<c-d>"
        "<c-u>"
        "<c-f>"
        "<c-b>"
      ]
      (kmap: {
        action = "${kmap.key}zz";
      })
    )
    # go to correct indentation when entering insert mode
    ++ (genkeymaps [ "n" ] [ "i" "a" ] (kmap: {
      action = helpers.mkRaw ''
        function ()
          return vim.api.nvim_get_current_line():match('%g') == nil and 'cc' or kmap.key
        end
      '';
      options = {
        expr = true;
        noremap = true;
        desc = "enter insert mode, with correct indentation";
      };
    }));
}
