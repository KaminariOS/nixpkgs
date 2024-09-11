{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "heygpt";
  version = "0.24.0";
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];
  src = fetchFromGitHub {
    owner = "fuyufjh";
    repo = "heygpt";
    rev = "3be31cb78971380de02f8f370658be931f1c645c";
    hash = "sha256-oP0yIdYytXSsbZ2pNaZ8Rrak1qJsudTe/oP6dGncGUM=";
  };
  cargoHash = "sha256-vAW6YCIwikA3H69p6gufhfVZuxGGNAEEX2vpyn8/ALg=";
}
