{
  osConfig,
  self,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  bindings = import ./bindings.nix;
  configuration =
    withHDR:
    let
      isDesktop = self.nixosConfigurations.desktop.config == osConfig;
      overrideHDR = if withHDR then lib.mkForce else lib.id;
    in
    overrideHDR {
      # overrideHDR to prevent duplication of list options
      programs.hyprlock.enable = true;

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        xwayland.enable = true;
        package = null;
        portalPackage = null;
        plugins = with inputs.hyprland-plugins.packages.x86_64-linux; [
          hyprbars
        ];

        settings =
          let
            hdrOptions = ", cm, hdr, sdrbrightness, 1.35, sdrsaturation, 1.35";
          in
          {
            monitor =
              # lib.optionals isDesktop
              ([
                "HDMI-A-1, 1920x1080@60.00, 0x0, 1, bitdepth,8"
                ("DP-2, 2560x1440@239.99, 1920x-350, 1, bitdepth, 10" + lib.optionalString withHDR hdrOptions)
              ])
              ++ [ ", preferred, auto, auto" ];

            # Leave at default if withHDR is not specified
            experimental = lib.mkIf withHDR { xx_color_management_v4 = true; };

            #####################
            ### LOOK AND FEEL ###
            #####################

            # Refer to https://wiki.hyprland.org/Configuring/Variables/

            # https://wiki.hyprland.org/Configuring/Variables/#general
            general = {
              gaps_in = 5;
              gaps_out = 5;

              border_size = 2;

              "col.active_border" = "$maroon $peach 45deg";
              "col.inactive_border" = "$overlay1";

              resize_on_border = false;

              allow_tearing = true;

              layout = "dwindle";
            };
            cursor = {
              default_monitor = "DP-2";
            };

            # https://wiki.hyprland.org/Configuring/Variables/#decoration
            decoration =
              let
                opacity = 1.0;
              in
              {
                rounding = 10;

                # Change transparency of focused and unfocused windows
                active_opacity = opacity;
                inactive_opacity = opacity;

                shadow = {
                  enabled = true;
                  range = 4;
                  render_power = 3;
                  color = "$peach";
                  color_inactive = "rgba(00000088)";
                  offset = "1 1";
                };

                # https://wiki.hyprland.org/Configuring/Variables/#blur
                blur = {
                  enabled = true;
                  size = 3;
                  passes = 2;

                  vibrancy = 0.135; # 1.696
                };
              };

            # https://wiki.hyprland.org/Configuring/Variables/#animations
            animations = {
              enabled = true;

              # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

              bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

              animation = [
                "windows, 1, 7, myBezier"
                "windowsOut, 1, 7, default, popin 70%"
                "border, 1, 10, default"
                "borderangle, 1, 8, default"
                "fade, 1, 7, default"
                "workspaces, 1, 6, default"
              ];
            };

            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            dwindle = {
              pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = true; # You probably want this
            };

            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            master = {
              new_status = "master";
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
              kb_variant = "nodeadkeys";
              follow_mouse = 1;

              sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

              touchpad = {
                natural_scroll = false;
              };
            };

            # https://wiki.hyprland.org/Configuring/Variables/#gestures
            gestures = {
              workspace_swipe = false;
            };

            # Example per-device config
            # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
            device = {
              name = "epic-mouse-v1";
              sensitivity = -0.5;
            };

            ####################
            ### KEYBINDINGSS ###
            ####################
            # Variables
            inherit (bindings)
              "$mod"
              "$term"
              "$menu"
              "$browser"
              "$fileManager"
              ;

            # Bindings
            bind =
              bindings.windowManipulation
              ++ bindings.workspaceManipulation
              ++ bindings.screenshot
              ++ bindings.audioControls
              ++ bindings.programShortcuts;

            binde = bindings.audioControlsRepeat;
            bindm = bindings.mouseBindings;

            ##############################
            ### WINDOWS AND WORKSPACES ###
            ##############################
            # Example windowrule v2
            windowrulev2 = [
              "suppressevent maximize, class:.*" # You'll probably like this.
              "immediate, class:^(gamescope)$"
              "immediate, class:steam_app_.*"
            ];
          };
      };

      home.packages = [ pkgs.kdePackages.qtsvg ];
    };
  hdrEnabled = osConfig.chaotic.hdr.enable;
  specialisationEnabled = osConfig.chaotic.hdr.specialisation.enable;

  specialisationConfig = lib.mkIf (hdrEnabled && specialisationEnabled) {
    specialisation.hdr.configuration = (configuration true);
  };
  normalConfig = configuration (hdrEnabled && !specialisationEnabled);
in
lib.mkMerge [
  specialisationConfig
  normalConfig
]
