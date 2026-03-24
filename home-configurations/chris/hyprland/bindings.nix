{ lib, ... }:
let
  exec =
    mods: key: app:
    "${mods}, ${key}, exec, ${app}";
  superExec = exec "SUPER";
  noctalia = cmd: "noctalia-shell ipc call ${cmd}";
in
{
  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

  "$mod" = "SUPER";
  "$term" = "ghostty";
  "$browser" = "zen-beta";
  "$fileManager" = "nemo";

  programShortcuts =
  [
    (superExec "Q" "$term")
    (superExec "E" "$fileManager")
    (superExec "N" "$browser")

    (superExec "SPACE" (noctalia "launcher toggle"))
    (superExec "L" (noctalia "lockScreen lock"))
    (exec "" "PRINT" (noctalia "plugin:screen-shot-and-record screenshot"))
  ];

  windowManipulation = [
    "$mod, C, killactive,"
    "$mod, F, togglefloating,"

    "$mod, RETURN, fullscreen,"
    "$mod SHIFT, RETURN, layoutmsg, fit active" # maximize

    "$mod, TAB, layoutmsg, colresize +conf"

    # Move focus with mainMod + arrow keys
    "$mod, left, layoutmsg, focus l"
    "$mod, right, layoutmsg, focus r"
    "$mod, up, layoutmsg, focus u"
    "$mod, down, layoutmsg, focus d"

    "$mod, mouse_up, layoutmsg, move +200"
    "$mod, mouse_down, layoutmsg, move -200"

    # Move window between monitors
    "$mod SHIFT, left, layoutmsg, movewindowto l"
    "$mod SHIFT, right, layoutmsg, movewindowto r"
  ]
  ++ (map (i: "$mod SHIFT, ${toString (lib.mod i 10)}, movetoworkspace, ${toString i}") (
    lib.range 1 10
  ));

  workspaceManipulation = [
    # Move workspace to window
    "$mod CONTROL, left, movecurrentworkspacetomonitor, +1"
    "$mod CONTROL, right, movecurrentworkspacetomonitor, -1"

  ]
  ++ (map (i: "$mod, ${toString (lib.mod i 10)}, workspace, ${toString i}") (lib.range 1 10));

  # Move/resize windows with mainMod + LMB/RMB and dragging
  mouseBindings = [
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];

  audioControls = [
    (exec "" "XF86AudioMute" (noctalia "volume muteOutput"))
  ];

  audioControlsRepeat =
    [
      (exec "" "XF86AudioRaiseVolume" (noctalia "volume increase"))
      (exec "" "XF86AudioLowerVolume" (noctalia "volume decrease"))
    ];

  brightnessControlsRepeat =
    [
      (exec "" "XF86MonBrightnessUp" (noctalia "brightness increase"))
      (exec "" "XF86MonBrightnessDown" (noctalia "brightness decrease"))
    ];

  windowGestures = [
    "3, left, dispatcher, layoutmsg, focus r"
    "3, right, dispatcher, layoutmsg, focus l"
    "2, pinch, resize"
    "3, down, float"
  ];
}
