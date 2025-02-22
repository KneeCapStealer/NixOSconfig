{ pkgs, ... }:
let
  bindings = import ./bindings.nix;
  env = import ./env.nix;
in
{
  programs.hyprlock.enable = true;

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.enable = false;
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,auto";

    # XDG not needed as uwsm is used
    env = env.QT ++ env.NVIDIA ++ env.OTHER;

    #####################
    ### LOOK AND FEEL ###
    #####################

    # Refer to https://wiki.hyprland.org/Configuring/Variables/

    # https://wiki.hyprland.org/Configuring/Variables/#general
    general = {
      gaps_in = 5;
      gaps_out = 5;

      border_size = 2;

      "col.active_border" = "$red $maroon 45deg";
      "col.inactive_border" = "$overlay1";

      resize_on_border = false;

      allow_tearing = true;

      layout = "dwindle";
    };


    # https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration = let
      opacity = 1.0;
    in {
      rounding = 10;

      # Change transparency of focused and unfocused windows
      active_opacity = opacity;
      inactive_opacity = opacity;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "$maroon";
        color_inactive = "rgba(00000000)";
        offset = "1 1";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#blur
      blur = {
        enabled = true;
        size = 3;
        passes = 1;

        vibrancy = 0.1696;
      };
    };


    # https://wiki.hyprland.org/Configuring/Variables/#animations
    animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
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
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
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
    inherit (bindings) "$mod" "$term" "$menu" "$browser" "$fileManager";
    
    # Bindings
    bind = bindings.windowManipulation
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

      # Streaming from XWayland
      "opacity 0.0 override, class:^(xwaylandvideobridge)$"
      "noanim, class:^(xwaylandvideobridge)$"
      "noinitialfocus, class:^(xwaylandvideobridge)$"
      "maxsize 1 1, class:^(xwaylandvideobridge)$"
      "noblur, class:^(xwaylandvideobridge)$"
      "nofocus, class:^(xwaylandvideobridge)$"
    ];
  };

  home.packages = [ pkgs.kdePackages.qtsvg ];
}
