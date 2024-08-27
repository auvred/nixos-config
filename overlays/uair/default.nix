# nixpkgs.uair doesn't contain --exit flag from this commit https://github.com/metent/uair/commit/be7d23b092fe658b02ae98c8c1884759de454d00
final: prev: {
  uair = prev.uair.override {
    rustPlatform.buildRustPackage = args:
      final.rustPlatform.buildRustPackage (args
        // {
          # src = prev.fetchFromGitHub {
          #   owner = prev.uair.src.owner;
          #   repo = prev.uair.src.repo;
          #   rev = "9b1fbe1f1f07cb22455742eef69d1f6585dbb091";
          #   hash = "sha256-6Z2DI7kbAcQkxaCphkakQIuC1XPz5Bj4OncjR2w8DAg=";
          # };
          # cargoHash = "sha256-OZYTVVHOibX816MbdE8SFcExtJzVw266X9sQKkC2mIE=";
          #
          # TODO: wait for this pr to get merged
          # https://github.com/metent/uair/pull/23
          src = prev.fetchFromGitHub {
            owner = "thled";
            repo = prev.uair.src.repo;
            rev = "eb0789a8e8881ad99d83321b51240f63c71bc03f";
            hash = "sha256-QJuIncyBazaCD3LeaeypSCFL72Czn9fPKQYGULxoP0M=";
          };
          cargoHash = "sha256-QnVKb8DApG65eoNT7OIwpy4q2osaSMabk2lF6bC5+WQ=";
          patches = [
            # without this patch (syscall caught with strace):
            # execve("/nix/store/...-systemd-255.6/bin//sh", ["sh", "-c", "..."...], 0xXXX /* 36 vars */) = -1 ENOENT (No such file or directory)
            #
            # maybe this can be solved by adding some buildInputs or something
            # like that, but I'm really lazy to try it right now
            ./absolute-path-to-sh.patch
          ];
        });
  };
}
