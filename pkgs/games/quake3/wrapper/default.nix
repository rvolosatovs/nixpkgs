{ stdenv, buildEnv, lib, libGL, quake3e, makeWrapper }:

{ paks, name ? (lib.head paks).name, description ? "" }:

let
  libPath = lib.makeLibraryPath [ libGL stdenv.cc.cc ];
  env = buildEnv {
    name = "quake3-env";
    paths = [ quake3e ] ++ paks;
  };

in stdenv.mkDerivation {
  name = "${name}-${quake3e.name}";

  nativeBuildInputs = [ makeWrapper ];

  buildCommand = ''
    mkdir -p $out/bin

    # We add Mesa to the end of $LD_LIBRARY_PATH to provide fallback
    # software rendering. GCC is needed so that libgcc_s.so can be found
    # when Mesa is used.
    makeWrapper ${env}/bin/quake3e.x64 $out/bin/quake3 \
      --suffix-each LD_LIBRARY_PATH ':' "${libPath}" \
      --add-flags "+set fs_basepath ${env} +set r_allowSoftwareGL 1"

    makeWrapper ${env}/bin/quake3e.ded.x64 $out/bin/quake3-server \
      --add-flags "+set fs_basepath ${env}"
  '';

  meta = {
    inherit description;
  };
}
