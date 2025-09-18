{self, ...}: {
  system.defaults = {
    ".GlobalPreferences"."com.apple.mouse.scaling" = 1.5;
    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "Automatic";
      "com.apple.mouse.tapBehavior" = 1;
    };
    WindowManager.EnableStandardClickToShowDesktop = false;
    controlcenter = {
      AirDrop = false;
      BatteryShowPercentage = false;
      Bluetooth = false;
      Display = false;
      FocusModes = false;
      NowPlaying = false;
      Sound = false;
    };
    dock = {
      autohide = true;
      autohide-delay = 0.1;
      orientation = "bottom";
      expose-group-apps = true;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
      FXRemoveOldTrashItems = true;
    };
    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 2;
      ShowDayOfWeek = false;
    };
    spaces.spans-displays = false;
    trackpad.Clicking = true;
  };
}
