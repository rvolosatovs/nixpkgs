{ lib, python3Packages }:

with python3Packages;

buildPythonApplication rec {
  pname = "python-miio";
  version = "0.4.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0dmwniing5xwqcfi4w891h6svnbsyxwc9d90953qcja4djgzsfdd";
  };

  propagatedBuildInputs = [
    appdirs
    attrs
    click
    construct
    cryptography
    netifaces
    pre-commit
    pytz
    tqdm
    zeroconf
  ];

  doCheck = false;

  checkInputs = [
    pytest
  ];

  meta = with lib; {
    homepage = https://github.com/rytilahti/python-miio;
    description = "Python library & console tool for controlling Xiaomi smart appliances";
    license = licenses.gpl3;
    maintainers = with maintainers; [ rvolosatovs ];
  };
}
