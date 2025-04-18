{
  plugins.oil.enable = true;
  plugins.oil.settings = {
    skip_confirm_for_simple_edits = true;
    use_default_keymaps = true;
  };

  keymaps = [
    {
      action = "<cmd>Oil<CR>";
      key = "<leader>e";
      options.silent = true;
    }
  ];
}
