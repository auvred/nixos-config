{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake.url = "github:auvred/neovim-flake";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    neovim-flake,
    treefmt-nix,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    nixosConfigurations.bekdoor = nixpkgs.lib.nixosSystem {
      modules = [
        ./machines/bekdoor
        {
          nixpkgs.overlays = [
            (import ./overlays/lemurs)
            (import ./overlays/runst)
            (import ./overlays/uair)
            (final: prev: {auvred-neovim = neovim-flake.packages.${system}.nvim;})
          ];
        }
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.auvred = import ./hm-modules;
          };
        }
      ];
    };
    formatter.${system} =
      (treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs = {
          alejandra.enable = true;
        };
      })
      .config
      .build
      .wrapper;
  };
}
