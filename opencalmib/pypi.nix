{
  fetchPypi
}:

buildPythonPackage {
  pname = "opencamlib";
  version = "2023.1.11";
  format = "wheel";
  src = fetchPypi rec {
    inherit pname version format;
    sha256 = ""; # TODO
    dist = python;
    python = "py3";
    #abi = "none";
    #platform = "any";
  };
}