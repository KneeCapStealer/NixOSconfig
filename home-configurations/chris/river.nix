{
  inputs,
  ...
}:
{

  wayland.windowManager.river = {
    enable = true;
    package = inputs.river.packages.x86_64-linux.river;
    settings = {
    };
  };
}
