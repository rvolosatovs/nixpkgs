{ lib, buildPythonPackage, fetchPypi
, appdirs, colorama, fasteners, future, intelhex, junit-xml
, lockfile, prettytable, pyserial, requests, six
}:

buildPythonPackage rec {
  pname = "mbed-os-tools";
  version = "0.0.9";

  src = fetchPypi {
    inherit pname version;
    sha256 = "09v9a3hh6nfz7iv7c9wi6sjysck5z25mh1bq4bmikadnk227yh4s";
  };

  propagatedBuildInputs = [
    appdirs
    colorama
    fasteners
    future
    intelhex
    junit-xml
    lockfile
    prettytable
    pyserial
    requests
    six
  ];

  doCheck = false;

  meta = with lib; {
    homepage = https://github.com/ARMmbed/mbed-os-tools;
    description = "List processing tools and functional utilities";
    license = licenses.apache2;
    maintainers = with maintainers; [ rvolosatovs ];
  };
}
