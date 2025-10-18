{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    # enableZshIntegration = true;
    attachExistingSession = true;
    # exitShellOnExit = true;
    settings = {
      keybinds = {
        tab = {
          "bind \"Shift Left\"" = {
            MoveTab = "Left";
          };
          "bind \"Shift Right\"" = {
            MoveTab = "Right";
          };
          "bind \"Shift h\"" = {
            MoveTab = "Left";
          };
          "bind \"Shift l\"" = {
            MoveTab = "Right";
          };
        };
      };
    };
    layouts = {
      dev = {
        layout = {
          _children = [
            {
              default_tab_template = {
                _children = [
                  {
                    pane = {
                      size = 1;
                      borderless = true;
                      plugin = {
                        location = "zellij:tab-bar";
                      };
                    };
                  }
                  {children = {};}
                  {
                    pane = {
                      size = 1;
                      borderless = true;
                      plugin = {
                        location = "zellij:status-bar";
                      };
                    };
                  }
                ];
              };
            }
            {
              tab = {
                _props = {
                  name = "goku";
                  focus = true;
                };
                _children = [
                  {
                    pane = {
                      command = "ssh";
                      args = ["goku"];
                    };
                  }
                  {
                    pane = {
                      command = "ssh";
                      args = ["goku"];
                    };
                  }
                ];
              };
            }
            {
              tab = {
                _props = {
                  name = "vegeta";
                };
                _children = [
                  {
                    pane = {
                      command = "lazygit";
                    };
                  }
                ];
              };
            }
            {
              tab = {
                _props = {
                  name = "local";
                };
                _children = [
                  {
                    pane = {
                      command = "yazi";
                    };
                  }
                ];
              };
            }
            {
              tab = {
                _props = {
                  name = "Shell";
                };
                _children = [
                  {
                    pane = {
                      command = "zsh";
                    };
                  }
                ];
              };
            }
          ];
        };
      };
    };
  };
}
