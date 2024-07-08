{pkgs, ...}: {
  imports = [
    ../../nixos-modules/lemurs
    ../../nixos-modules/podman.nix
    ./hardware-configuration.nix
  ];

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:win_space_toggle";
  };

  time.timeZone = "Europe/Riga";

  networking = {
    hostName = "bekdoor";
    # TODO: import networkmanager config
    networkmanager.enable = true;
  };

  hardware.keyboard.qmk.enable = true;

  users = {
    mutableUsers = false;
    users.auvred = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      home = "/home/auvred";
      createHome = true;
      hashedPassword = "$y$j9T$PGQ2y/7y8s75LNmZbzJsD1$RuE3vBao55zBsIKCigxTCQr.y8wIcaJoTymGorlCAA6";
      shell = pkgs.zsh;
    };
  };

  programs = {
    zsh.enable = true;
    # https://nix-community.github.io/home-manager/index.xhtml#_why_do_i_get_an_error_message_about_literal_ca_desrt_dconf_literal_or_literal_dconf_service_literal
    dconf.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["CascadiaMono"];})
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    htop
  ];

  services.dbus.packages = [pkgs.runst];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
