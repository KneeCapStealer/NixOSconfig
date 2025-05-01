{
  imports = [
    ./nix.nix
    ./fidget.nix
  ];

  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;

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
