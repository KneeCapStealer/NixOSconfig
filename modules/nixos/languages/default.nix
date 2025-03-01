{ config, ... }:
let
  cfg = config.languages;
  boolToInt = b: if b then 1 else 0;
in
{
  imports = [
    ./danish.nix
  ];

  # Make sure only 1 language is enabled, or errors occur
  assertions =
    let
      numEnabledLanguages = builtins.foldl' (
        numEnabled: language: numEnabled + (boolToInt cfg.${language}.enable)
      ) 0 (builtins.attrNames cfg);
    in
    [
      {
        assertion = numEnabledLanguages < 2;
        message = "No more than one (1) language may be enabled at a time";
      }
    ];
}
