{ pkgs, lib, ... }:
{
  environment = {
    sessionVariables = {
      # Good uwsm default settings:
      UWSM_USE_SESSION_SLICE = "true";
      UWSM_APP_UNIT_TYPE = "service";

      # wayland qt settings
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

      GTK_BACKEND = "wayland,x11,*";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";

      NIXOS_OZONE_WL = 1;

      AQ_DRM_DEVICES = "/dev/dri/intel-igpu:/dev/dri/nvidia-dgpu";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
    systemPackages = with pkgs; [
      hyprshot
      wl-clipboard
    ];
  };

  services.udev.packages = lib.singleton (
    pkgs.runCommand "gpu-dev-path-rules" { } ''
      mkdir -p $out/lib/udev/rules.d

      cat <<EOF > $out/lib/udev/rules.d/70-intel-igpu-dev-path.rules
      KERNEL=="card*", \
      KERNELS=="0000:00:02.0", \
      SUBSYSTEM=="drm", \
      SUBSYSTEMS=="pci", \
      SYMLINK+="dri/intel-igpu"
      EOF

      cat <<EOF > $out/lib/udev/rules.d/70-nvidia-dgpu-dev-path.rules
      KERNEL=="card*", \
      KERNELS=="0000:01:00.0", \
      SUBSYSTEM=="drm", \
      SUBSYSTEMS=="pci", \
      SYMLINK+="dri/nvidia-dgpu"
      EOF
    ''
  );
}
