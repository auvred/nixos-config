{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./flameshot.nix
    ./fzf.nix
    ./git.nix
    ./gitui.nix
    ./gtk.nix
    ./i3.nix
    ./librewolf.nix
    ./neovim.nix
    ./nodejs.nix
    ./ripgrep.nix
    ./tmux.nix
    ./uair.nix
    ./zsh.nix
  ];
  home = {
    stateVersion = "24.05";

    packages = with pkgs; [
      bat
      alejandra
      cool-retro-term
      fd
      jq
      nix-diff
      qmk
    ];

    sessionVariables = {
      PULUMI_HOME = "$XDG_DATA_HOME/pulumi";
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
      NX_NO_CLOUD = "true";
    };
  };
}
