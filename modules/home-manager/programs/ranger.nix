# DOESN'T WORK BECAUSE THE DUDE WHO MADE
# THE COLORSCHEME MADE SYNTAX ERRORS
# AND I AM TOO LAZY TO FIX THEM

# I will use Yazi instead
# R.I.P.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkMerge
    mkIf
    mergeAttrsList
    filesystem
    sources
    types
    ;
  cfg = config.programs.ranger;
in
{
  options.programs.ranger = {
    catppuccin = {
      enable = mkEnableOption "catppuccin theme for ranger by dfrico";
      flavor = mkOption {
        type = types.enum [
          "mocha"
          "latte"
          "macchiato"
        ];
        default = "mocha";
        description = "Which catppuccin flavor to use";
        example = "latte";
      };
    };
    makeDefault = mkEnableOption "ranger as the default file manager";
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.catppuccin.enable {
      programs.ranger = {
        settings = {
          colorscheme = "catppuccin_${cfg.catppuccin.flavor}";
        };
      };

      xdg.configFile =
        let
          src = pkgs.fetchFromGitHub {
            owner = "dfrico";
            repo = "catppuccin-ranger";
            rev = "95d214817eb309f14444dd006de316842c578c29";
            hash = "sha256-BxfkINaOax9MukYRyvqdBUcgG84lwf0AQAeAcV/Uh4E=";
          };
          filtered = sources.sourceFilesBySuffices src [ ".py" ];
          filenames = map (filepath: builtins.baseNameOf filepath) (filesystem.listFilesRecursive filtered); # and this took me so long because of ass documentation :')
        in
        mergeAttrsList (
          map (filename: {
            "ranger/colorschemes/${builtins.unsafeDiscardStringContext filename}".source =
              filtered + "/${filename}";
          }) filenames
        );
    })

    (mkIf cfg.makeDefault {
      home.sessionVariables = {
        FILEMANAGER = "ranger";
      };
    })
  ]);
}
