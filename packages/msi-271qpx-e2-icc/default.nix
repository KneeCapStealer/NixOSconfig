{
  stdenvNoCC,
  fetchzip,
}: stdenvNoCC.mkDerivation {
  pname = "msi-271qpx-e2-icc";
  version = "2024-04-26";

  src = fetchzip {
    url = "https://download.msi.com/dvr_exe/monitor/MS-3CD8-MAG-271QPX-QD-OLED-E2-INF.zip";
    hash = "sha256-ew2I6ePKQXlCMck10CAsBvHT41MC3NdJ5+prIqtwGK0=";
  };

  strictDeps = true;
  noConfigure = true;
  noBuild = true;

  installPhase = ''
    mkdir -p $out/share/color/icc
    cp "$src/MAG 271QPX E2.icm" $out/share/color/icc/
  '';

  passthru.iccFilePath = "/share/color/icc/MAG 271QPX E2.icm";


  meta.description = "Icc profile for the MSI MAG 271QPX E2 monitor";
}
