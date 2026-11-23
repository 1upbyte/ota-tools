{
  lib,
  fetchFromGitHub,
  rustPlatform,
  stdenv,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "afsr";
  version = "2.1.1";

  src = fetchFromGitHub {
    owner = "chenxiaolong";
    repo = "afsr";
    tag = "v${finalAttrs.version}";
    fetchSubmodules = true;
    hash = "sha256-QHF8j5q01s0KZZv1UzBHdhzvV87yHfoEAXC4ZmPhdpY=";
  };

  cargoHash = "sha256-ADHixxc7lTOZF1rAGyzIucHtCTKoH3Y8ImcTY5jlG3E=";

  nativeBuildInputs = [ rustPlatform.bindgenHook ];

  # The bundled e2fsprogs stub omits unused parameter names in a C function definition.
  env = lib.optionalAttrs stdenv.cc.isClang {
    NIX_CFLAGS_COMPILE = "-Wno-error=c23-extensions";
  };

  meta = {
    description = "Unpack and pack Android filesystem images reproducibly";
    homepage = "https://github.com/chenxiaolong/afsr";
    license = lib.licenses.gpl2Only;
    mainProgram = "afsr";
  };
})
