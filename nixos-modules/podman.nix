{pkgs, ...}: {
  environment.systemPackages = [pkgs.podman-compose];
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
    };
  };
}
