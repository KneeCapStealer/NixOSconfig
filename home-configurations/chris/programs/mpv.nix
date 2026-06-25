{ host, lib, ... }:
{
  programs.mpv.enable = true;
  programs.mpv.config = lib.mkMerge [
    (lib.mkIf (host == "desktop") {
      profile = "high-quality";
      fullscreen = "yes";
      cursor-autohide = 200;

      # Audio language prio
      alang = "ja,jp,jpn,en,eng";

      # Subtitle language prio
      slang = "en,eng";

      vo = "gpu-next";
      gpu-api = "vulkan";
      gpu-context = "waylandvk";
      hwdec = "vulkan";

      dither-depth = 10;
      dither = "error-diffusion";
      error-diffusion = "floyd-steinberg";

      target-colorspace-hint = "yes";
      target-contrast = "inf";
      target-prim = "display-p3";
      target-trc = "pq";
      target-peak = 1000;
    })
  ];
}
