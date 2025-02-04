{
  lib,
  stdenv,
  fetchFromGitHub,
  boost,

  # Args to override
  version,
  sourceRev,
  sourceHash
}:

stdenv.mkDerivation rec {
  pname = "opencamlib";

  inherit version;

  src = fetchFromGitHub {
    owner = "aewallin";
    repo = "opencamlib";
    rev = sourceRev;
    hash = sourceHash;
  };

  nativeBuildInputs = [
    camke
    boost
  ];

  CMAKE_FLAGS = ''
    -D CXX_LIB="ON"
    -D BOOST_ROOT=/path/to/boost
  '';

  buildInputs = [

  ];

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
