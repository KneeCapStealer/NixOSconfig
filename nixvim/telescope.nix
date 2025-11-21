{
  dependencies.ripgrep.enable = true;
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Telescope fuzzy find files";
      };

      "<leader>fg" = {
        action = "live_grep";
        options.desc = "Telescope live grep";
      };

      "<leader>fr" = {
        action = "lsp_references";
        options.desc = "Telescope list all LSP references for word";
      };

      "<leader>fd" = {
        action = "diagnostics";
        options.desc = "Telescope list all diagnostics for all open buffers";
      };

      "gd" = {
        action = "lsp_definitions";
        options.desc = "Telescope Go to Definition";
      };

      "gD" = {
        action = "lsp_implementations";
        options.desc = "Telescope Go to implementation";
      };

      "<leader>h" = {
        action = "keymaps";
        options.desc = "Telescope show keymaps";
      };
    };
    settings = {
      defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.zig-cache/"
        ];
      };
    };
  };
}
