final: prev: {
  runst = prev.rustPlatform.buildRustPackage rec {
    pname = "runst";
    version = "0.1.7";

    nativeBuildInputs = [prev.pkg-config];
    buildInputs = [prev.dbus prev.gtk2];

    src = prev.fetchFromGitHub {
      owner = "orhun";
      repo = "runst";
      rev = "refs/tags/v${version}";
      sha256 = "sha256-0xPJc7C+hgPsv5F0qDE2xoWbXJR4u4p5HQr8uLvnTSA=";
    };

    postInstall = ''
      mkdir -p $out/share/dbus-1/services
      cat << EOF > $out/share/dbus-1/services/org.orhun.runst.service
      [D-BUS Service]
      Name=org.freedesktop.Notifications
      Exec=$out/bin/runst
      EOF
    '';

    cargoHash = "sha256-f/2K99nLQ11i/T1GfnP3LDHzSs4TlcDvSBJ8IepJhvA=";
  };
}
