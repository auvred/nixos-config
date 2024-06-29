{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    extraConfig = ''
      set -g renumber-windows on
      set -g status-bg color235
      set -g status-fg white
    '';
  };
}
