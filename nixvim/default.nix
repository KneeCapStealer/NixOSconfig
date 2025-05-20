{
  imports = [
    ./lsp

    ./cmp.nix
    ./mini.nix
    ./oil.nix
    ./treesitter.nix
    ./ufo.nix
    ./zig.nix
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
}
