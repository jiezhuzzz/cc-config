{
  services.aerospace = {
    enable = true;
    settings = {
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 30;
      default-root-container-layout = "accordion";
      default-root-container-orientation = "auto";
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
      automatically-unhide-macos-hidden-apps = false;
      key-mapping = {
        preset = "qwerty";
      };
      gaps = {
        inner = {
          horizontal = 10;
          vertical = 10;
        };
        outer = {
          left = 10;
          bottom = 10;
          top = 5;
          right = 10;
        };
      };
      mode = {
        main = {
          binding = {
            "alt-slash" = "layout tiles horizontal vertical";
            "alt-comma" = "layout accordion horizontal vertical";
            "alt-h" = "focus left";
            "alt-j" = "focus down";
            "alt-k" = "focus up";
            "alt-l" = "focus right";
            "alt-shift-h" = "move left";
            "alt-shift-j" = "move down";
            "alt-shift-k" = "move up";
            "alt-shift-l" = "move right";
            "alt-shift-minus" = "resize smart -50";
            "alt-shift-equal" = "resize smart +50";
            "alt-w" = "workspace W";
            "alt-c" = "workspace C";
            "alt-t" = "workspace T";
            "alt-o" = "workspace O";
            "alt-shift-w" = "move-node-to-workspace W";
            "alt-shift-c" = "move-node-to-workspace C";
            "alt-shift-t" = "move-node-to-workspace T";
            "alt-shift-o" = "move-node-to-workspace O";
            "alt-tab" = "workspace-back-and-forth";
            "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";
            "alt-shift-semicolon" = "mode service";
          };
        };
        service = {
          binding = {
            "esc" = ["reload-config" "mode main"];
            "r" = ["flatten-workspace-tree" "mode main"];
            "f" = ["layout floating tiling" "mode main"];
            "backspace" = ["close-all-windows-but-current" "mode main"];
            "alt-shift-h" = ["join-with left" "mode main"];
            "alt-shift-j" = ["join-with down" "mode main"];
            "alt-shift-k" = ["join-with up" "mode main"];
            "alt-shift-l" = ["join-with right" "mode main"];
            "down" = "volume down";
            "up" = "volume up";
            "shift-down" = ["volume set 0" "mode main"];
          };
        };
      };
      on-window-detected = [
        {
          "if".app-id = "company.thebrowser.Browser";
          run = "move-node-to-workspace W";
        }
        {
          "if".app-id = "company.thebrowser.dia";
          run = "move-node-to-workspace W";
        }
        {
          "if".app-id = "app.zen-browser.zen";
          run = "move-node-to-workspace W";
        }
        {
          "if".app-id = "com.apple.Safari";
          run = "move-node-to-workspace W";
        }
        {
          "if".app-id = "org.zotero.zotero";
          run = "move-node-to-workspace W";
        }
        {
          "if".app-id = "com.mitchellh.ghostty";
          run = "move-node-to-workspace T";
        }
        {
          "if".app-id = "com.raphaelamorim.rio";
          run = "move-node-to-workspace T";
        }
        {
          "if".app-id = "com.microsoft.VSCode";
          run = "move-node-to-workspace C";
        }
        {
          "if".app-id = "com.todesktop.230313mzl4w4u92";
          run = "move-node-to-workspace C";
        }
        {
          "if".app-id = "dev.zed.Zed";
          run = "move-node-to-workspace C";
        }
        {
          "if".app-id = "md.obsidian";
          run = "move-node-to-workspace O";
        }
        {
          check-further-callbacks = true;
          run = "layout floating";
        }
      ];
      workspace-to-monitor-force-assignment = {
        W = "main";
        C = "RD280U";
        T = "PD2725U";
      };
    };
  };
}
