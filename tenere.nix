{
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "tenere";
  version = "0.24.0";

  src = fetchFromGitHub {
    owner = "pythops";
    repo = "tenere";
    rev = "a99f83904b0db9516079530ca53cf23da50df492";
    hash = "sha256-upezAU2TpdPe0/sdpjIO4S8d1ifdDmSNa7fJ21q/QqU=";
  };
  cargoHash = "sha256-Z3mcTEoLFu223sXV/GYLO+xNBd0CWjw24K/UD/A4Iq0=";
}
