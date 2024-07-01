{
  config,
  pkgs,
  ...
}: let
  virtualTerminalNumber = 2;
  pamServiceName = "lemurs";
in {
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    dpi = 90;
    # ligthdm is enabled by default (when services.xserver.enable is true), so we need to turn it off
    displayManager.lightdm.enable = false;
  };

  systemd.services.lemurs = {
    aliases = ["display-manager.service"];
    after = ["systemd-user-sessions.service" "plymouth-quit-wait.service" "getty@tty${toString virtualTerminalNumber}.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = let
      lemursConfig = (pkgs.formats.toml {}).generate "lemurs-config.toml" (let
        startXServer = let dm = config.services.xserver.displayManager; in "${dm.xserverBin} ${toString dm.xserverArgs}";
        startHomeManagerXSession = pkgs.writeTextFile {
          name = "lemurs-hm-xsession";
          text = ''
            USERXSESSION=$HOME/.xsession-hm
            if [ -f "$USERXSESSION" ]; then
              exec "$USERXSESSION"
            fi
            exec ${pkgs.xorg.xmessage}/bin/xmessage -center -buttons OK:0 -default OK "Sorry, can't find xsession start script ($USERXSESSION)."
          '';
          executable = true;
          destination = "/hm-xsession";
        };
      in {
        tty = virtualTerminalNumber;
        pam_service = pamServiceName;
        system_shell = "${pkgs.bash}/bin/bash";
        max_display_length = 15;

        power_controls.base_entries = [
          {
            hint = "Shutdown";
            hint_color = "dark gray";
            hint_modifiers = "";
            key = "F1";
            cmd = "${pkgs.systemd}/bin/systemctl poweroff";
          }
          {
            hint = "Reboot";
            hint_color = "dark gray";
            hint_modifiers = "";
            key = "F2";
            cmd = "${pkgs.systemd}/bin/systemctl reboot";
          }
        ];

        x11 = {
          xserver_path = startXServer;
          xsetup_path = "${./xsetup.sh}";
          scripts_path = "${startHomeManagerXSession}";
        };
      });
    in {
      ExecStart = "${pkgs.lemurs}/bin/lemurs --config ${lemursConfig}";
      StandardInput = "tty";
      TTYPath = "/dev/tty${toString virtualTerminalNumber}";
      TTYReset = "yes";
      TTYVHangup = "yes";
      Type = "idle";
    };
  };

  security.pam.services = {
    ${pamServiceName}.text = ''
      auth include login
      account include login
      session include login
      password include login
    '';
    # See https://github.com/coastalwhite/lemurs/issues/166
    login.setLoginUid = false;
  };

  # I want my systemd-logind(8) session to access to seat0 (the default seat
  # with all hardware devices).
  # At the very least, I want to be able to change backlight without tweaking
  # udev rules and directly accessing /sys/class/backlight.
  # See systemd-logind(8), sd-login(3), org.freedesktop.login1(5), pam_systemd(8)
  # for more details.
  #
  # -----
  #
  # pam_systemd(8) tries to get XDG_SEAT and XDG_VTNR variables from environment.
  # https://github.com/systemd/systemd/blob/main/src/login/pam_systemd.c#L967-L968
  #
  # It passes seat and vntr to the
  # org.freedesktop.login1
  #   -> /org/freedesktop/login1
  #      -> org.freedesktop.login1.Manager
  #         -> CreateSession(in s seat_id, in u vtnr, ...)
  #
  # See org.freedesktop.login1(5) for more details.
  #
  # AFAIK lemurs doesn't pass either XDG_SEAT or XDG_VTNR to the PAM process.
  # See also https://github.com/1wilkens/pam/issues/13.
  #
  # pam_env(8) PAM module is located before pam_systemd(8) in /etc/pam.d/login.
  # So variables set by pam_env are visible to pam_systemd.
  # environment.sessionVariables are written to /etc/pam/environment and then
  # read by pam_systemd.
  environment.sessionVariables = {
    XDG_SEAT = "seat0";
    XDG_VTNR = "${toString virtualTerminalNumber}";
  };

  # Useful for pam_systemd debugging
  # security.pam.services.login.rules.session.systemd.args = ["debug"];
}
