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

  diagnostics = {
    virtual_text = true;
  };
}
