{
  lib,
  makeWrapper,
  runCommand,
  bash,
  jq,
}:
  let
    # Make sure to place nvimunity in the same directory as this derivation, or adjust the following path
    src = ./nvimunity.sh;
    binName = "nvimunity";
    deps = [
      bash
      jq
    ];
  in
  runCommand "${binName}"
    {
      nativeBuildInputs = [ makeWrapper ];
      meta = {
        mainProgram = "${binName}";
      };
    }
    ''
      mkdir -p $out/bin
      install -m +x ${src} $out/bin/${binName}
      wrapProgram $out/bin/${binName} \
        --prefix PATH : ${lib.makeBinPath deps}
    ''
