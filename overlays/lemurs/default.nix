# The latest published version (0.3.2) doesn't contain a patch with xserver_path option
# https://github.com/coastalwhite/lemurs/commit/ef4b42de1391f3d35d7827130d20bc57d06198f9
final: prev: {
  lemurs = prev.lemurs.override {
    rustPlatform.buildRustPackage = args:
      final.rustPlatform.buildRustPackage (args
        // {
          src = prev.fetchFromGitHub {
            owner = "coastalwhite";
            repo = "lemurs";
            rev = "9bc429735c2b5284c68cecb6e9789a4eabf3a83a";
            hash = "sha256-WGisoaIPgJimFGhnLctWmRTE/ycRpCshpPq2ZFdlyAM=";
          };
          cargoHash = "sha256-hKeJaIGUZpbuca3IPN1Uq4bamgImfYNvCRiVDbriHPA=";
          patches = [
            ./use-system-shell-in-key-menu.patch
          ];
        });
  };
}
