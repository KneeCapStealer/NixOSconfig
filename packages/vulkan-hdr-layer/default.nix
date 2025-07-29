{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  pkg-config,
  vulkan-loader,
  ninja,
  writeText,
  vulkan-headers,
  vulkan-utility-libraries,
  jq,
  libX11,
  libXrandr,
  libxcb,
  wayland,
  wayland-scanner,
}:

stdenv.mkDerivation {
  pname = "vulkan-hdr-layer";
  version = "63d2eec";

  src = 
    fetchFromGitHub {
      owner = "Zamundaaa";
      repo = "VK_hdr_layer";
      rev = "7c0553d88b38e62eb7fd83f3d25f50733309c866";
      fetchSubmodules = true;
      hash = "sha256-arJJWel6WooZ4SHwl0NXK44xOMgHMo1n++eJSVrone4=";
    };

  nativeBuildInputs = [
    vulkan-headers
    wayland-scanner
    meson
    ninja
    pkg-config
    jq
  ];

  buildInputs = [
    vulkan-headers
    vulkan-loader
    vulkan-utility-libraries
    libX11
    libXrandr
    libxcb
    wayland
  ];

  # Help vulkan-loader find the validation layers
  setupHook = writeText "setup-hook" ''
    addToSearchPath XDG_DATA_DIRS @out@/share
  '';

  meta = with lib; {
    description = "Layers providing Vulkan HDR";
    homepage = "https://github.com/Zamundaaa/VK_hdr_layer";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
