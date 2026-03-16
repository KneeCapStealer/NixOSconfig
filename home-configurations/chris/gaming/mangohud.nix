{
  programs.mangohud.enable = true;
  programs.mangohud.settings = {
    fps_metrics = "avg,0.01,0.001";
    legacy_layout=false;
    round_corners=10;
    background_alpha=0.8;
    background_color="1E1E2E";
    table_columns=3;

## Text ##
    font_size=24;
    text_color="CDD6F4";
    text_outline_color=313244;

## GPU ##
    gpu_text="GPU";
    gpu_stats=true;
    gpu_temp=true;
    gpu_color="A6E3A1";
    gpu_load_change=true;
    gpu_load_color="CDD6F4,FAB387,F38BA8";

## CPU ##
    cpu_text="CPU";
    cpu_stats=true;
    cpu_temp=true;
    cpu_color="89B4FA";
    cpu_load_change=true;
    cpu_load_color="CDD6F4,FAB387,F38BA8";

## RAM ##
    ram=true;
    ram_color="F5C2E7";

## ENGINE ##
    engine_color="F38BA8";

## FPS ##
    fps=true;
    fps_color_change="F38BA8,F9E2AF,A6E3A1";

## Wine ##
    wine=true;
    wine_color="F38BA8";
    winesync=true;

## Frame timing ##
    frame_timing=true;
    frametime_color="A6E3A1";

    arch=true;
    fps_limit_method="early";
    toggle_fps_limit="Shift_L+F1";
  };
  catppuccin.mangohud.enable = false;
}
