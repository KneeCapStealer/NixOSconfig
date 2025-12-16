{
  programs.mpv.enable = true;
  programs.mpv.config = {
    gpu-context = "waylandvk";
    vo = "gpu-next";
    gpu-api = "vulkan";
    target-colorspace-hint = "auto";
    target-peak = 1000;
    target-trc = "pq";
  };
}
