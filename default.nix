with import <nixpkgs> {};

# (python37.withPackages (ps: with ps; [
#   virtualenvwrapper
# ])).env

with import <nixpkgs> {};
with python37Packages;

stdenv.mkDerivation {
  name = "seafilePythonEnv";

  src = null;

  buildInputs = [
    # these packages are required for virtualenv and pip to work:
    #
    python37Full
    python37Packages.virtualenv
    python37Packages.pip
    python37Packages.six
    python37Packages.docker
    python37Packages.setuptools
    # the following packages are related to the dependencies of your python
    # project.
    docker
    gnumake
    taglib
    openssl
    git
    libxml2
    libxslt
    libzip
    stdenv
    zlib
    gzip
  ];

  shellHook = ''
    # set SOURCE_DATE_EPOCH so that we can use python wheels
    SOURCE_DATE_EPOCH=$(date +%s)
    virtualenv --no-setuptools venv
    export PATH=$PWD/venv/bin:$PATH
    pip install docker-squash
  '';
}
