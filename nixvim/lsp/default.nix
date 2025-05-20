
{
  imports = [
    ./nix.nix
    ./fidget.nix
  ];

  plugins = {
    cmp-nvim-lsp.enable = true;
    lsp = {
      enable = true;
      inlayHints = true;
      capabilities = ''
        local old = capabilities
        capabilities = require("cmp_nvim_lsp").default_capabilities(old)
      '';

      onAttach = ''
        local opts = { noremap = false, silent = true, buffer = bufnr }

        vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<S-d>', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<A-d>', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rf', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, opts)
        vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
      '';

      servers = {
        nixd.enable = true;
        zls.enable = true;
        phpactor.enable = true;
      };
    };
  };

  diagnostic.settings = {
    virtual_text = true;
  };
}
