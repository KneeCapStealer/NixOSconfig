{ lib, pkgs, ... }:
let
  helpers = lib.nixvim;
in
{
  imports = [
    ./nix.nix
    ./qml.nix
    ./fidget.nix
  ];

  plugins = {
    cmp-nvim-lsp.enable = true;
    none-ls.enable = true;
    lspconfig = {
      enable = true;
    };
  };

  lsp = {
    inlayHints.enable = false;
    onAttach = ''
      local opts = { noremap = false, silent = true, buffer = bufnr }
      local lsp = vim.lsp

      vim.keymap.set('n', 'K', lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>ws', lsp.buf.workspace_symbol, opts)
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '<S-d>', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<A-d>', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', '<leader>ca', lsp.buf.code_action, opts)
      vim.keymap.set('i', '<C-h>', lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>ih', function () lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled()) end, opts)
      vim.keymap.set('n', '<leader>rn', lsp.buf.rename, opts)
    '';

    servers = {
      "*".config = {
        capabilities = helpers.mkRaw "require('cmp_nvim_lsp').default_capabilities()";
      };
      nixd.enable = true;
      zls.enable = true;
      glsl_analyzer.enable = true;
      basedpyright.enable = true;
      clangd = {
        enable = true;
        package = pkgs.llvmPackages_latest.clang-tools;
      };
      hsl.enable = true;
    };
  };

  diagnostic.settings = {
    virtual_text = true;
  };
}
