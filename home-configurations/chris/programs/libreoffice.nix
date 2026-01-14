{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice-qt
    (hunspell.withDicts (dicts: [ dicts.en_GB-ize dicts.da_DK ]))
  ];
}
