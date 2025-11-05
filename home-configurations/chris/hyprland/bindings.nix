{ lib, ... }:
let
  exec =
    mods: key: app:
    "${mods}, ${key}, exec, uwsm app -- ${app}";
  superExec = exec "SUPER";
in
{
  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

  "$mod" = "SUPER";
  "$term" = "foot.desktop";
  "$browser" = "zen-beta.desktop";
  "$fileManager" = "nemo.desktop";

  programShortcuts = [
    (superExec "Q" "$term")
    (superExec "E" "$fileManager")
    (superExec "N" "$browser")
    (superExec "ESCAPE" "eww open powermenu")
    "$mod SHIFT, E, exec, caelestia emoji -p"
  ];

  caelestiaGlobals = [
    "$mod, SPACE, global, caelestia:launcher"
    "$mod, l, global, caelestia:lock"
  ];

  windowManipulation = [
    "$mod, C, killactive,"
    "$mod, M, exit,"
    "$mod, F, togglefloating,"
    "$mod, RETURN, fullscreen,"
    "$mod, TAB, layoutmsg, colresize +conf"
    "$mod, P, pseudo, # dwindle"
    "$mod, J, togglesplit, # dwindle"

    # Move focus with mainMod + arrow keys
    "$mod, left, layoutmsg, focus l"
    "$mod, right, layoutmsg, focus r"
    "$mod, up, layoutmsg, focus u"
    "$mod, down, layoutmsg, focus d"

    "$mod, mouse_up, layoutmsg, focus l"
    "$mod, mouse_down, layoutmsg, focus r"

    # Move window between monitors
    "$mod SHIFT, left, layoutmsg, movewindowto l"
    "$mod SHIFT, right, layoutmsg, movewindowto r"

    "$mod SHIFT, 0, movetoworkspace, 10"
  ]
  ++ (map (i: "$mod SHIFT, ${toString i}, movetoworkspace, ${toString i}") (lib.range 1 9));

  workspaceManipulation = [
    # Move workspace to window
    "$mod CONTROL, left, movecurrentworkspacetomonitor, +1"
    "$mod CONTROL, right, movecurrentworkspacetomonitor, -1"

    # Switch workspaces with mainMod + [0-9]
    "$mod, 0, workspace, 10"
  ]
  ++ (map (i: "$mod, ${toString i}, workspace, ${toString i}") (lib.range 1 9));

  # Move/resize windows with mainMod + LMB/RMB and dragging
  mouseBindings = [
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];

  screenshot =
    let
      execScreenShot = mods: mode: exec mods "PRINT" "hyprshot --freeze --clipboard-only -m ${mode}";
    in
    [
      ", PRINT, global, caelestia:screenshotFreeze"
    ];

  audioControls = [
    (exec "" "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
  ];

  audioControlsRepeat =
    let
      max = "1.2";
      increment = "5%";
    in
    [
      (exec "" "XF86AudioRaiseVolume" "wpctl set-volume -l ${max} @DEFAULT_AUDIO_SINK@ ${increment}+")
      (exec "" "XF86AudioLowerVolume" "wpctl set-volume -l ${max} @DEFAULT_AUDIO_SINK@ ${increment}-")
    ];

  brightnessControlsRepeat =
    let
      increment = "5%";
    in
    [
      (exec "" "XF86MonBrightnessUp" "brightnessctl s ${increment}+")
      (exec "" "XF86MonBrightnessDown" "brightnessctl s ${increment}-")
    ];

  windowGestures = [
    "3, left, dispatcher, layoutmsg, focus r"
    "3, right, dispatcher, layoutmsg, focus l"
    "2, pinch, resize"
    "3, down, float"
  ];
}
