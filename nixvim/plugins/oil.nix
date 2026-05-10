{ lib, ... }:
let
  helpers = lib.nixvim;
in
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
      options.desc = "Open the Oil file explorer";
    }
    {
      action = helpers.mkRaw "function() require('oil').toggle_hidden() end";
      key = "H";
      options.desc = "Toggle hidden files";
    }
  ];
}
