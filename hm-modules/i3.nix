{
  config,
  lib,
  pkgs,
  ...
}: {
  xsession = {
    enable = true;
    scriptPath = ".xsession-hm";
    windowManager.i3 = {
      enable = true;
      config = {
        terminal = "alacritty";
        modifier = "Mod4";
        defaultWorkspace = "workspace number 1";
        focus = {followMouse = false;};
        window = {
          border = 1;
          titlebar = false;
          hideEdgeBorders = "smart";
        };
        startup =
          [
            (let
              xsetOptions = [
                "b off" # disable bell
                "r rate 200 45" # autorepeat - "r rate <delay before autorepeat start> <repeats per second>"
                # TODO: enable i3lock and dpms "dpms 0 0 1200"
              ];
            in {
              command = "${pkgs.xorg.xset}/bin/xset ${builtins.toString xsetOptions}";
              always = true;
              notification = false;
            })
          ]
          ++ (
            let
              xinputProps = {
                # TODO: is there a better way?
                # Not sure if this should be put in the nixosConfiguration
                "MSFT0001:00 04F3:31DD Touchpad" = {
                  "libinput Tapping Enabled" = [1];
                  "libinput Natural Scrolling Enabled" = [1];
                };
              };
            in (
              lib.flatten (
                lib.mapAttrsToList
                (deviceName: deviceOpts: (
                  lib.mapAttrsToList (optName: optValue: {
                    command = "${pkgs.xorg.xinput}/bin/xinput set-prop ${lib.escapeShellArg deviceName} ${lib.escapeShellArg optName} ${builtins.toString optValue}";
                    always = true;
                    notification = false;
                  })
                  deviceOpts
                ))
                xinputProps
              )
            )
          );

        bars = [
          (let
            i3statusRustConfig = (pkgs.formats.toml {}).generate "config.toml" {
              block = [
                {
                  block = "custom";
                  command = "echo COOLKID bek";
                  interval = "once";
                }

                {
                  block = "backlight";
                }

                {
                  block = "battery";
                  format = " $icon $percentage{ $time |} ";
                  full_format = " $icon $percentage{ $time |} ";
                  charging_format = " $icon $percentage{ $time |} ";
                  empty_format = " $icon $percentage{ $time |} ";
                  not_charging_format = " $icon $percentage{ $time |} ";
                }

                {
                  block = "custom";
                  command = "${pkgs.uair}/bin/uairctl listen --exit";
                  interval = 1;
                  click = [
                    {
                      button = "left";
                      sync = true;
                      update = true;
                      cmd = "${pkgs.uair}/bin/uairctl toggle";
                    }
                    {
                      button = "right";
                      sync = true;
                      update = true;
                      cmd = "${pkgs.uair}/bin/uairctl next";
                    }
                  ];
                }

                {
                  block = "cpu";
                  interval = 1;
                  format = " $icon $utilization ";
                  format_alt = " $icon $utilization $barchart ";
                }
                {
                  block = "memory";
                  interval = 1;
                  format = " $icon $mem_used_percents.eng(width:2) ";
                }
                {
                  block = "time";
                  interval = 1;
                  format = " $timestamp.datetime(f:'%a %d-%m-%Y %T') ";
                }
              ];
            };
          in {
            position = "top";
            fonts.size = 7.5;
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${i3statusRustConfig}";
          })
        ];

        keybindings = let
          mod = config.xsession.windowManager.i3.config.modifier;
        in
          lib.mkOptionDefault {
            "${mod}+h" = "focus left";
            "${mod}+j" = "focus down";
            "${mod}+k" = "focus up";
            "${mod}+l" = "focus right";

            "${mod}+Shift+h" = "move left";
            "${mod}+Shift+j" = "move down";
            "${mod}+Shift+k" = "move up";
            "${mod}+Shift+l" = "move right";

            "${mod}+Shift+Return" = "exec librewolf";
            "Print" = "exec flameshot gui";
          };
        modes = {
          resize = let
            resize = direction: "resize ${direction} 10px or 2ppt";
            escape = ''mode "default"'';
          in {
            h = resize "shrink width";
            j = resize "grow height";
            k = resize "shrink height";
            l = resize "grow width";

            Return = escape;
            Escape = escape;
          };
        };
      };
    };
  };
}
