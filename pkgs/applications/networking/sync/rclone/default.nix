{ stdenv, buildGoPackage, fetchFromGitHub, fuse, coreutils }:

buildGoPackage rec {
  name = "rclone-${version}";
  version = "1.40";

  goPackagePath = "github.com/ncw/rclone";

  src = fetchFromGitHub {
    owner = "ncw";
    repo = "rclone";
    rev = "v${version}";
    sha256 = "01q9g5g4va1s91xzvxpq8lj9jcrbl66cik383cpxwmcv04qcqgw9";
  };

  propagatedBuildInputs = [
    fuse coreutils
  ];

  outputs = [ "bin" "out" "man" ];

  inherit coreutils;

  postInstall = ''
    install -D -m644 $src/rclone.1 $man/share/man/man1/rclone.1

    substituteAll "${./rclonefs.sh}" "$bin/bin/rclonefs"
    chmod a+x $bin/bin/rclonefs
  '';


  meta = with stdenv.lib; {
    description = "Command line program to sync files and directories to and from major cloud storage";
    homepage = http://rclone.org;
    license = licenses.mit;
    maintainers = with maintainers; [ danielfullmer rvolosatovs ];
    platforms = platforms.all;
  };
}
