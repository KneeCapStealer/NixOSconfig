{
  fileSystems =
    let
      compress = "compress=zstd";
      nocompress = "compress=no";
      nocow = "nodatacow";

      default = [ compress ];
    in
    {
      "/".options = default;
      "/home".options = default;
      "/nix".options = default;
      "/tmp".options = default;
      "/var/log".options = default;
      "/var/cache".options = default;
      "/games".options = [
        nocompress
        nocow
      ];
    };
}
