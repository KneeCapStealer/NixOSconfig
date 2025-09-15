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
  };

  keymaps = [
    {
      action = "<C-d>zz";
      key = "<C-d>";
    }
    {
      action = "<C-u>zz";
      key = "<C-u>";
    }
  ];
}
