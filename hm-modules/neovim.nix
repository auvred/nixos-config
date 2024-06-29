{pkgs, ...}: {
  home = {
    packages = [
      (pkgs.auvred-neovim.overrideAttrs {
        fixupPhase = ''
          ln -s $out/bin/nvim $out/bin/vi
        '';
      })
    ];
    sessionVariables = {EDITOR = "nvim";};
  };
}
