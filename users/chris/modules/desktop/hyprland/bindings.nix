let
  exec = mods: key: app: "${mods}, ${key}, exec, uwsm app -- ${app}";
  superExec = exec "SUPER";
in {
  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

  "$mod" = "SUPER";
  "$term" = "kitty";
  "$menu" = "rofi -show drun -show-icons -run-command \"uwsm app -- {cmd}\"";
  "$browser" = "zen";
  "$fileManager" = "dolphin";

  programShortcuts = [
    (superExec "Q" "$term")
    (superExec "E" "$fileManager")
    (superExec "SPACE" "$menu")
    (superExec "N" "$browser")
    (superExec "ESCAPE" "eww open powermenu")
  ];

  windowManipulation = [
    "$mod, C, killactive,"
    "$mod, M, exit,"
    "$mod, F, togglefloating,"
    "$mod, RETURN, fullscreen,"
    "$mod, P, pseudo, # dwindle"
    "$mod, J, togglesplit, # dwindle"


    # Move focus with mainMod + arrow keys
    "$mod, left, movefocus, l"
    "$mod, right, movefocus, r"
    "$mod, up, movefocus, u"
    "$mod, down, movefocus, d"

    # Move focus with mainMod + vimkeys
    "$mod, H, movefocus, l"
    "$mod, J, movefocus, d"
    "$mod, K, movefocus, u"
    "$mod, L, movefocus, r"
  ];

  workspaceManipulation = [
    # Switch workspaces with mainMod + [0-9]
    "$mod, 1, workspace, 1"
    "$mod, 2, workspace, 2"
    "$mod, 3, workspace, 3"
    "$mod, 4, workspace, 4"
    "$mod, 5, workspace, 5"
    "$mod, 6, workspace, 6"
    "$mod, 7, workspace, 7"
    "$mod, 8, workspace, 8"
    "$mod, 9, workspace, 9"
    "$mod, 0, workspace, 10"

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    "$mod SHIFT, 1, movetoworkspace, 1"
    "$mod SHIFT, 2, movetoworkspace, 2"
    "$mod SHIFT, 3, movetoworkspace, 3"
    "$mod SHIFT, 4, movetoworkspace, 4"
    "$mod SHIFT, 5, movetoworkspace, 5"
    "$mod SHIFT, 6, movetoworkspace, 6"
    "$mod SHIFT, 7, movetoworkspace, 7"
    "$mod SHIFT, 8, movetoworkspace, 8"
    "$mod SHIFT, 9, movetoworkspace, 9"
    "$mod SHIFT, 0, movetoworkspace, 10"

    # Scroll through existing workspaces with mainMod + scroll
    "$mod, mouse_down, workspace, e+1"
    "$mod, mouse_up, workspace, e-1"
    ];

  # Move/resize windows with mainMod + LMB/RMB and dragging
  mouseBindings = [
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];

  screenshot = let
    execScreenShot = mods: mode: exec mods "PRINT" "hyprshot --freeze --clipboard-only -m ${mode}";
  in [
    (execScreenShot "" "active")
    (execScreenShot "SHIFT" "region")
    (execScreenShot "SUPER" "output")
  ];

  audioControls = [
    (exec "" "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
  ];

  audioControlsRepeat = let
    max = "1.2";
    increment = "5%";
  in [
    (exec "" "XF86AudioRaiseVolume" "wpctl set-volume -l ${max} @DEFAULT_AUDIO_SINK@ ${increment}+")
    (exec "" "XF86AudioLowerVolume" "wpctl set-volume -l ${max} @DEFAULT_AUDIO_SINK@ ${increment}-")
  ];
}
