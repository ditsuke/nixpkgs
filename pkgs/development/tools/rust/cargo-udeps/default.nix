{ lib, stdenv, rustPlatform, fetchFromGitHub, pkg-config, openssl, CoreServices, Security, libiconv, SystemConfiguration }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-udeps";
  version = "0.1.41";

  src = fetchFromGitHub {
    owner = "est31";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-LfPhs3hTM47ktDSSC5TVYQoJa4OzMfL7zKLWV4d6bAA=";
  };

  cargoHash = "sha256-NBxQ75J60kZX6ASk3/42N5JT6pDLEZpnZtUCgRDOvSY=";

  nativeBuildInputs = [ pkg-config ];

  # TODO figure out how to use provided curl instead of compiling curl from curl-sys
  buildInputs = [ openssl ]
    ++ lib.optionals stdenv.isDarwin [ CoreServices Security libiconv SystemConfiguration ];

  # Requires network access
  doCheck = false;

  meta = with lib; {
    description = "Find unused dependencies in Cargo.toml";
    homepage = "https://github.com/est31/cargo-udeps";
    license = licenses.mit;
    maintainers = with maintainers; [ b4dm4n matthiasbeyer ];
  };
}
