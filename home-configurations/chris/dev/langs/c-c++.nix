{ pkgs, ... }:

{
  home.packages = with pkgs.llvmPackages_latest; [
    llvm
    lldb
    openmp
    compiler-rt-libc
    libunwind
    libcxx
    libcxxStdenv
    bintools
    clangUseLLVM
    lld
  ];
}
