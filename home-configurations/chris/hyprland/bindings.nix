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
  "$term" = "ghostty";
  "$browser" = "zen.desktop";
  "$fileManager" = "nemo.desktop";

  programShortcuts = [
    (superExec "Q" "$term")
    (superExec "E" "$fileManager")
    (superExec "N" "$browser")
    (superExec "ESCAPE" "eww open powermenu")
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
    "$mod, P, pseudo, # dwindle"
    "$mod, J, togglesplit, # dwindle"

    # Move focus with mainMod + arrow keys
    "$mod, left, movefocus, l"
    "$mod, right, movefocus, r"
    "$mod, up, movefocus, u"
    "$mod, down, movefocus, d"

    # Move window between monitors
    "$mod SHIFT, left, movewindow, l"
    "$mod SHIFT, right, movewindow, r"

    "$mod SHIFT, 0, movetoworkspace, 10"
  ] ++ (map (i: "$mod SHIFT, ${toString i}, movetoworkspace, ${toString i}") (lib.range 1 9));

  workspaceManipulation = [
    # Scroll through existing workspaces with mainMod + scroll
    "$mod, mouse_down, workspace, e+1"
    "$mod, mouse_up, workspace, e-1"

    # Move workspace to window
    "$mod CONTROL, left, movecurrentworkspacetomonitor, +1"
    "$mod CONTROL, right, movecurrentworkspacetomonitor, -1"

    # Switch workspaces with mainMod + [0-9]
    "$mod, 0, workspace, 10"
  ] ++ (map (i: "$mod, ${toString i}, workspace, ${toString i}") (lib.range 1 9));

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
}
