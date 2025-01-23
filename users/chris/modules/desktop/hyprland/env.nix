{
  XDG = [
    "XDG_SESSION_DESKTOP,Hyprland"
    "XDG_CURRENT_DESKTOP,Hyprland"
    "XDG_SESSION_TYPE,wayland"
  ];
  QT = [
    "QT_AUTO_SCREEN_SCALE_FACTOR,1"
    "QT_QPA_PLATFORM,wayland;xcb"
    "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
  ];
  NVIDIA = [
    "GBM_BACKEND,nvidia-drm"
    "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    "LIBVA_DRIVER_NAME,nvidia"
    "__GL_GSYNC_ALLOWED,1"
    "__GL_VRR_ALLOWED,0"
  ];
  OTHER = [
    "GDK_BACKEND,wayland,x11,*"
    "SDL_VIDEODRIVER,wayland"
    "CLUTTER_BACKEND,wayland"
  ];
}
