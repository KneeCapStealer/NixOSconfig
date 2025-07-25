{
  imports = [
    ./nix.nix
    ./qml.nix
    ./fidget.nix
  ];

  plugins = {
    cmp-nvim-lsp.enable = true;
    lsp = {
      enable = true;
      inlayHints = false;
      capabilities = ''
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      '';

      onAttach = ''
        local opts = { noremap = false, silent = true, buffer = bufnr }
        local lsp = vim.lsp

        vim.keymap.set('n', 'gd', lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>ws', lsp.buf.workspace_symbol, opts)
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<S-d>', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<A-d>', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>ca', lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rf', lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rr', lsp.buf.rename, opts)
        vim.keymap.set('i', '<C-h>', lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>ih', function () lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled()) end, opts)
        vim.keymap.set('n', '<leader>rn', lsp.buf.rename, opts)
      '';

      servers = {
        nixd.enable = true;
        zls.enable = true;
        phpactor.enable = true;
        glsl_analyzer.enable = true;
        qmlls.enable = true;
        qmlls.cmd = [
          "qmlls"
          "-E"
        ];
      };
    };
  };

  diagnostic.settings = {
    virtual_text = true;
  };
}
