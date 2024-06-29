{pkgs, ...}: {
  programs.ripgrep = {
    enable = true;
    arguments = ["--glob=!.git/*"];
  };
}
