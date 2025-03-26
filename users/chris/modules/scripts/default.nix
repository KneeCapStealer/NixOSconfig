{ pkgs, ... }:
{
  home.packages = [
    (pkgs.buildEnv {
      name = "scripts";
      paths = [ "${./.}"];
    })
  ];
}
