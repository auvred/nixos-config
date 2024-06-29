{
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.uair];
  xdg.configFile = {
    "uair/uair.toml".source = (pkgs.formats.toml {}).generate "uair.toml" {
      loop_on_end = true;

      defaults = {
        format = "{name} {time}";
      };

      sessions = let
        notifySend = msg: "${pkgs.libnotify}/bin/notify-send " + (lib.escapeShellArgs ["-t" "999999999" msg]);
      in [
        {
          id = "work";
          name = "Work";
          duration = "35m";
          command = notifySend "work session is done";
        }
        {
          id = "rest";
          name = "Rest";
          duration = "5m";
          command = notifySend "rest session is done";
        }
      ];
    };
  };
  systemd.user.services.uair = {
    Service.ExecStart = "${pkgs.uair}/bin/uair --quiet";
    Install.WantedBy = ["default.target"];
  };
}
