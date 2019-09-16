{ lib, python3Packages, git, mercurial }:

with python3Packages;

buildPythonApplication rec {
  pname = "mbed-cli";
  version = "1.10.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "150aldvj9msxdfdsn0mh2i706yiqp2h383ax9gmyn4nrfkf2yskz";
  };

  buildInputs = [
    git
    mercurial
  ];

  propagatedBuildInputs = [
    mbed-os-tools
    pip
    pyserial
  ];

  doCheck = false;

  checkInputs = [
    git
    mercurial
    pytest
  ];

  checkPhase = ''
    export GIT_COMMITTER_NAME=nixbld
    export EMAIL=nixbld@localhost
    export GIT_COMMITTER_DATE=$SOURCE_DATE_EPOCH
    pytest test
  '';

  meta = with lib; {
    homepage = "https://github.com/ARMmbed/mbed-cli";
    description = "Arm Mbed Command Line Interface";
    license = licenses.asl20;
    maintainers = with maintainers; [ rvolosatovs ];
  };
}

