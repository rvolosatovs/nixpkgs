{ stdenv, lib, fetchFromGitHub, rustPlatform, nix }:

rustPlatform.buildRustPackage rec {
  pname = "rnix-lsp";
  version = "0.3.0-alejandra";

  src = fetchFromGitHub {
    owner = "nix-community";
    repo = "rnix-lsp";
    # https://github.com/nix-community/rnix-lsp/pull/89
    rev = "9189b50b34285b2a9de36a439f6c990fd283c9c7";
    sha256 = "sha256-ZnUtvwkcz7QlAiqQxhI4qVUhtVR+thLhG3wQlle7oZg=";
  };

  cargoSha256 = "sha256-VhE+DspQ0IZKf7rNkERA/gD7iMzjW4TnRSnYy1gdV0s=";
  cargoBuildFlags = [ "--no-default-features" "--features" "alejandra" ];

  checkInputs = lib.optional (!stdenv.isDarwin) nix;

  meta = with lib; {
    description = "A work-in-progress language server for Nix, with syntax checking and basic completion";
    license = licenses.mit;
    maintainers = with maintainers; [ ma27 ];
  };
}
