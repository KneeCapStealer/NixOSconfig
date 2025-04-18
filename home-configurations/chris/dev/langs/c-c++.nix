{ pkgs, ... }:
{
  home.packages = with pkgs.llvmPackages_latest; [
    bolt
    bintools
    clangUseLLVM
    lld
    lldb
    openmp
  ];
}
