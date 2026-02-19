{
  programs.mpv.enable = true;
  programs.mpv.config = {
    gpu-context = "waylandvk";
    hwdec = "auto-copy";
    vo = "gpu-next";
    gpu-api = "vulkan";
    target-colorspace-hint = "yes";
    target-colorspace-hint-mode = "source";
    target-peak = 1000;
    target-trc = "pq";
    target-prim = "dci-p3";
  };
}
