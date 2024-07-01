{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      nodejs_20
      corepack_20
    ];
    sessionVariables = {
      NPM_CONFIG_CACHE = "$XDG_CACHE_HOME/npm";
      NODE_REPL_HISTORY = "$XDG_STATE_HOME/node_repl_history";
    };
  };
}
