{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
  boost,
  cmake,
}:

stdenv.mkDerivation rec {
  pname = "opencamlib";
  version = "dev";

  src = fetchFromGitHub {
    owner = "oscilococcinum";
    repo = "opencamlib-nix";
    rev = "master";
    hash = "sha256-BaROCKrxXBUwHbqsXyiW7HXER4cf+wH6MeQ+2o0BAMA=";
  };

  nativeBuildInputs = [
    cmake
    boost
  ];

  CMAKE_FLAGS = ''
    -D CXX_LIB="ON"
    -D BOOST_ROOT=/path/to/boost
  '';

  buildInputs = [];

  outputs = [
    "out"
  ];

  buildPhase = ''
    cp -r $src/* $out
    mkdir $out/build
    cd $out/build
    cmake ..
  '';

  installPhase = ''
    make . -j6
    make install .
  '';

  meta = with lib; {
    description = "Free, open source CFD software";
    homepage = "https://github.com/aewallin/opencamlib";
    changelog = "https://github.com/aewallin/opencamlib/releases";
    license = licenses.lgpl21;
    maintainers = with maintainers; [ oscilococcinum ];
    platforms = lib.platforms.linux;
  };
}
