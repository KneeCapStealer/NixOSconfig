{ lib, ... }:
let
  helpers = lib.nixvim;
in
{
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings.sources = [
      { name = "nvim_lsp"; }
      { name = "path"; }
      { name = "buffer"; }
    ];

    settings = {
      mapping = helpers.mkRaw ''
          cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          })
        '';
      snippet = {
        expand = "function(args) require('luasnip').lsp_expand(args.body) end";
      };
    };
  };

  plugins.cmp_luasnip.enable = true;
  plugins.luasnip.enable = true;
}
