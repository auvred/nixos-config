{pkgs, ...}: {
  home.packages = [pkgs.flameshot];
  xdg.configFile = {
    "flameshot/flameshot.ini".source = (pkgs.formats.ini {}).generate "flameshot.ini" {
      General = {
        checkForUpdates = false;
        disabledTrayIcon = true;
        savePath = "/home/auvred/Downloads";
        savePathFixed = true;
        showDesktopNotification = false;
        showHelp = false;
        showStartupLaunchMessage = false;
        undoLimit = 100;
      };
    };
  };
}
