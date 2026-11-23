{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  protobuf,
  bzip2,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "custota-tool";
  version = "6.10";

  src = fetchFromGitHub {
    owner = "chenxiaolong";
    repo = "Custota";
    tag = "v${finalAttrs.version}";
    hash = "sha256-52PVjqVRihFYaAW+Fd7uho/Lklgu/6BCYCi7CSL0FzU=";
  };

  cargoHash = "sha256-+RsN3cn+Wc2jwmMa7w6FIxS0pO7qXWRrpk/bDdB10XQ=";

  # Upstream's build script only uses Git to determine the version string.
  postPatch = ''
    cat > custota-tool/build.rs <<'EOF'
    fn main() {
        println!("cargo:rustc-env=GIT_VERSION=v${finalAttrs.version}");
    }
    EOF
  '';

  nativeBuildInputs = [
    pkg-config
    protobuf
  ];

  buildInputs = [ bzip2 ];

  meta = {
    description = "Generate companion files for hosting Android A/B OTA updates with Custota";
    homepage = "https://github.com/chenxiaolong/Custota";
    license = lib.licenses.gpl3Only;
    mainProgram = "custota-tool";
  };
})
