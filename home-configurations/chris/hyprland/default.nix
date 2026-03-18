{
  pkgs,
  lib,
  host,
  inputs,
  self,
  ...
}@args:
let
  bindings = import ./bindings.nix args;
in
{
  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    xwayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    importantPrefixes = [
      "$"
      "bezier"
      "name"
      "source"
      "output"
    ];

    settings = {
      monitor = [
        ", preferred, auto, auto"
      ];

      exec-once = [
        "noctalia-shell"
      ];

      monitorv2 = lib.mkMerge [
        (lib.mkIf (host == "desktop") [
          {
            output = "DP-1";
            mode = "2560x1440@239.99";
            position = "1920x-350";
            scale = 1;
            bitdepth = 10;
            cm = "hdr";
            sdrbrightness = 1.35;
            sdrsaturation = 1.4;
            sdr_min_luminance = 0.005;
            supports_hdr = 1;
            supports_wide_color = 1;
            sdr_eotf = "srgb";
            # icc = 
            # let
            #   iccPkg = self.packages.${pkgs.stdenv.hostPlatform.system}.msi-271qpx-e2-icc;
            # in
            #   iccPkg + iccPkg.iccFilePath;
          }
          {
            output = "HDMI-A-1";
            mode = "1920x1080@59.94Hz";
            position = "0x0";
            scale = 1;
            bitdepth = 8;
          }
        ])
        (lib.mkIf (host == "laptop") [
          {
            output = "eDP-1";
            mode = "1920x1080@60.00Hz";
            position = "0x0";
            scale = 1;
            bitdepth = 8;
          }
        ])
      ];

      render.cm_sdr_eotf = "srgb";

      env = lib.mkIf (host == "laptop") [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
      #####################
      ### LOOK AND FEEL ###
      #####################

      # Refer to https://wiki.hyprland.org/Configuring/Variables/

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 3;
        gaps_out = 5;

        border_size = 2;

        "col.active_border" = "$peach $peach 45deg";
        "col.inactive_border" = "$overlay1";

        resize_on_border = false;

        allow_tearing = true;

        layout = "scrolling";
      };

      scrolling = {
        fullscreen_on_one_column = true;
        column_width = 0.5;
      };

      cursor = {
        default_monitor = lib.mkIf (host == "desktop") "DP-2";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration =
        let
          opacity = 1.0;
        in
        {
          rounding = 13;
          rounding_power = 2;

          # Change transparency of focused and unfocused windows
          active_opacity = opacity;
          inactive_opacity = opacity;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "$peach";
            color_inactive = "rgba(00000088)";
            offset = "0 1";
          };

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur = {
            enabled = true;

            size = 1;
            passes = 2;

            vibrancy = 1.6969;
          };
        };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
          "easeOutExpo, 0.16, 1.0, 0.3, 1.0"
          "easeinExpo, 0.7, 0, 0.84, 0"
        ];

        animation = [
          "windows, 1, 4, easeOutExpo"
          "windowsOut, 1, 5, default, slide"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 5, easeOutExpo"
        ];
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
      };

      #############
      ### INPUT ###
      #############

      # https://wiki.hyprland.org/Configuring/Variables/#input
      input = {
        kb_layout = "dk";
        follow_mouse = 1;
        repeat_delay = 400;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = true;
        };
      };

      gesture = bindings.windowGestures;

      ####################
      ### KEYBINDINGSS ###
      ####################
      # Variables
      inherit (bindings)
        "$mod"
        "$term"
        "$browser"
        "$fileManager"
        ;

      # Bindings
      bind =
        with bindings;
        windowManipulation ++ workspaceManipulation ++ screenshot ++ audioControls ++ programShortcuts;

      binde = bindings.audioControlsRepeat;
      bindm = bindings.mouseBindings;

      windowrule =
        with builtins;
        let
          # createGameRule :: [String] -> Attrset
          createGameRule =
            names:
            if !isList names then
              throw "createGameRule only accepts a list of strings as a parameter"
            else
              let
                # Create a string like so: "(game-1)|(game-2)|(Third Game Name: Preimium Edition)|"
                titleRegEx = foldl' (matchStr: gameName: matchStr + "(${gameName})|") "" names;
                # Cut off the trailing '|' character.
                titleRegEx' = substring 0 (stringLength titleRegEx - 1) titleRegEx;
              in
              {
                name = "immediate-no-idle-game";
                "match:title" = titleRegEx';

                immediate = "on";
                idle_inhibit = "focus";
              };
        in
        [
          (createGameRule [
            "steam_app_.*"
            "Hollow Knight Silksong"
            "The Witcher 3"
            "Clair Obscur: Expedition 33.*"
          ])

          {
            name = "immediate-no-idle-game-content";
            "match:content" = 3;

            immediate = "on";
            idle_inhibit = "focus";
          }
        ];
    };

  };
}
