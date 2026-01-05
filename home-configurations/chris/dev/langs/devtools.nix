{pkgs, ...}:
{
  home.packages = with pkgs; [
    llvmPackages_latest.llvm
    llvmPackages_latest.lldb
  ];
}
