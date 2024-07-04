final: prev: {
  podman-compose = prev.podman-compose.overrideAttrs {
    patches = [
      # See https://github.com/containers/podman-compose/issues/710
      ./podman-compose-up-wait.patch
    ];
  };
}
