{
  pkgs,
  lib,
}:
pkgs.glfw3.overrideAttrs {
  pname = "glfw3-minecraft-wayland";

  patches = [
    ./glfw-wayland/patches/0001-Key-Modifiers-Fix.patch
    ./glfw-wayland/patches/0002-Fix-duplicate-pointer-scroll-events.patch
    ./glfw-wayland/patches/0003-Implement-glfwSetCursorPosWayland.patch
    ./glfw-wayland/patches/0004-Fix-Window-size-on-unset-fullscreen.patch
    ./glfw-wayland/patches/0005-Avoid-error-on-startup.patch
  ];

  cmakeFlags = [
    (lib.cmakeBool "GLFW_BUILD_WAYLAND" true)
    (lib.cmakeBool "GLFW_BUILD_X11" false)

    (lib.cmakeBool "BUILD_SHARED_LIBS" true)

    (lib.cmakeBool "GLFW_BUILD_EXAMPLES" false)
    (lib.cmakeBool "GLFW_BUILD_TESTS" false)
    (lib.cmakeBool "GLFW_BUILD_DOCS" false)
  ];

  meta.platforms = lib.platforms.linux;
}
