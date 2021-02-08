{ lib, buildGoModule, fetchgit }:

buildGoModule rec {
  pname = "gotools-unstable";
  version = "2021-02-05";
  rev = "ef80cdb6ec6d94b8e8d05f986b368bf925fa330e";

  src = fetchgit {
    inherit rev;
    url = "https://go.googlesource.com/tools";
    sha256 = "0nrqj8qdv9gh4hryj9i0qsmjlrawykksqzij2qd9j25wr5hpq1g1";
  };

  # The gopls folder contains a Go submodule which causes a build failure.
  # Given that, we can't have the gopls binary be part of the gotools
  # derivation.
  #
  # The attribute "gopls" provides the gopls binary.
  #
  # Related
  #
  # * https://github.com/NixOS/nixpkgs/pull/85868
  # * https://github.com/NixOS/nixpkgs/issues/88716
  postPatch = ''
    rm -rf gopls
  '';

  vendorSha256 = "0i2fhaj2fd8ii4av1qx87wjkngip9vih8v3i9yr3h28hkq68zkm5";

  doCheck = false;

  postConfigure = ''
    # Make the builtin tools available here
    mkdir -p $out/bin
    eval $(go env | grep GOTOOLDIR)
    find $GOTOOLDIR -type f | while read x; do
      ln -sv "$x" "$out/bin"
    done
    export GOTOOLDIR=$out/bin
  '';

  excludedPackages = "\\("
    + lib.concatStringsSep "\\|" ([ "testdata" "vet" "cover" ])
    + "\\)";

  # Set GOTOOLDIR for derivations adding this to buildInputs
  postInstall = ''
    mkdir -p $out/nix-support
    substitute ${../../go-modules/tools/setup-hook.sh} $out/nix-support/setup-hook \
      --subst-var-by bin $out
  '';

  # Do not copy this without a good reason for enabling
  # In this case tools is heavily coupled with go itself and embeds paths.
  allowGoReference = true;
}
