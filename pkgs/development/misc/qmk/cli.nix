{ buildPythonApplication
, lib
, fetchFromGitHub
, appdirs
, dotty-dict
, flake8
, hjson
, jsonschema
, milc
, nose2
, pygments
, setuptools-scm
, yapf
}:

buildPythonApplication rec {
  pname = "qmk_cli";
  version = "0.0.39";

  src = fetchFromGitHub {
    owner = "qmk";
    repo = pname;
    rev = version;
    sha256 = "iBPRjFxPc14+56V2AzK+YVt0XKG8lq4ULYbvntlAVzQ=";
  };

  propagatedBuildInputs = [
    appdirs
    dotty-dict
    flake8
    hjson
    jsonschema
    milc
    nose2
    pygments
    setuptools-scm
    yapf
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://qmk.fm";
    description = "A program to help users work with QMK tools";
    license = with licenses; mit;
    maintainers = with maintainers; [ AndersonTorres ];
  };
}
