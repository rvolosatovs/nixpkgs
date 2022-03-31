{ lib, stdenv, fetchFromGitHub, fetchpatch, cmake, scdoc, util-linux }:

stdenv.mkDerivation rec {
  pname = "ydotool";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "ReimuNotMoe";
    repo = "ydotool";
    rev = "v${version}";
    sha256 = "sha256-maXXGCqB8dkGO8956hsKSwM4HQdYn6z1jBFENQ9sKcA=";
  };

  strictDeps = true;
  nativeBuildInputs = [ cmake scdoc ];

  postInstall = ''
    substituteInPlace ${placeholder "out"}/lib/systemd/user/ydotool.service \
      --replace /usr/bin/kill "${util-linux}/bin/kill"
  '';

  patches = [
    (fetchpatch {
      url = "https://github.com/ReimuNotMoe/ydotool/commit/a324939d7b4c2276d83563fa4313447e969f67da.patch";
      sha256 = "18br9fk8zkldqbq2qb6l3lqhvnsnfhx3ik5x7l6cznw8i16nc7bd";
    })
  ];

  meta = with lib; {
    homepage = "https://github.com/ReimuNotMoe/ydotool";
    description = "Generic Linux command-line automation tool";
    license = licenses.agpl3Plus;
    maintainers = with maintainers; [ willibutz kraem ];
    platforms = with platforms; linux;
  };
}
