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
    ];
  };
}
