{...}: {
  # TODO: https://github.com/nix-community/home-manager/pull/5128
  # add vimium extension
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      "privacy.clearOnShutdown.cache" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "privacy.clearOnShutdown.formdata" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.offlineApps" = false;
      "privacy.clearOnShutdown.openWindows" = false;
      "privacy.clearOnShutdown.sessions" = false;
      "privacy.clearOnShutdown.siteSettings" = false;
      "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = false;
      "browser.sessionstore.resume_from_crash" = false;
      "browser.uidensity" = 1;
      "layout.css.devPixelsPerPx" = "0.85";
    };
  };
}
