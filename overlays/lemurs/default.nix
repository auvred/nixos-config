# The latest published version (0.3.2) doesn't contain a following patches:
# - https://github.com/coastalwhite/lemurs/commit/ef4b42de1391f3d35d7827130d20bc57d06198f9
# - https://github.com/coastalwhite/lemurs/commit/849e7cea87f3567be7cec403a2a603b8370e351c
final: prev: {
  lemurs = prev.lemurs.override {
    rustPlatform.buildRustPackage = args:
      final.rustPlatform.buildRustPackage (args
        // {
          src = prev.fetchFromGitHub {
            owner = "coastalwhite";
            repo = "lemurs";
            rev = "1d4be7d0c3f528a0c1e9326ac77f1e8a17161c83";
            hash = "sha256-t/riJpgy0bD5CU8Zkzket4Gks2JXXSLRreMlrxlok0c=";
          };
          cargoHash = "sha256-hKeJaIGUZpbuca3IPN1Uq4bamgImfYNvCRiVDbriHPA=";
        });
  };
}
