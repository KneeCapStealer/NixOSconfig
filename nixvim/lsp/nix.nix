{
  extraFiles = {
    "ftplugin/nix.lua".text = ''
      vim.opt.tabstop = 2;
      vim.opt.shiftwidth = 2;
      vim.opt.expandtab = true;
    '';
  };
}
