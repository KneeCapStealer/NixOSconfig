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
    ./languages
    ./plugins

    ./treesitter.nix
    ./debugging.nix
  ];

  viAlias = true;
  vimAlias = true;
  withPython3 = false;
  withRuby = false;

  plugins.nix.enable = true;
  clipboard.providers.wl-copy.enable = true;
  globals.mapleader = " ";

  plugins.rustaceanvim.enable = true;

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavor = "mocha";
      integrations = {
        treesitter = true;
      };

      transparent_background = true;
      show_end_of_buffer = true;

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
          defaultkeymaps = map (key: {
            inherit mode key;
            action = key;
          }) keys;
        in
        map (kmap: kmap // f kmap) defaultkeymaps;

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
          return vim.api.nvim_get_current_line():match('%g') == nil and 'cc' or '${kmap.key}'
        end
      '';
      options = {
        expr = true;
        noremap = true;
        desc = "enter insert mode, with correct indentation";
      };
    }))
    ++ [
      {
        mode = [ "n" ];
        key = "<leader>fm";
        action = helpers.mkRaw ''
          function () vim.lsp.buf.format() end
        '';
        options.desc = "Format the current buffer";
      }
    ];
}
