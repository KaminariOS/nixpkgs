{
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "i3-focus-last";
  version = "0.24.0";

  src = fetchFromGitHub {
    owner = "lbonn";
    repo = "i3-focus-last";
    rev = "ef8affae96179568be5faa04fd1542ceb7285964";
    hash = "sha256-5IxBrZbzOif/PMYIqZP1wuVZ6ac2dWJwi6EVUd1lB7Q=";
  };
  cargoHash = "sha256-3IVgazdxtXR1+eXP3OZEfMsCSZ10LUh5bVDJ3NgvGts=";
}
