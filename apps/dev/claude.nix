let
  agentDir = ../../agents;
in {
  programs.claude-code = {
    enable = true;
    rulesDir = "${agentDir}/rules";
    skillsDir = "${agentDir}/skills";
    settings = {
      attribution = {
        commit = "";
        pr = "";
      };
      theme = "dark";
      alwaysThinkingEnabled = true;
      permissions.deny = [
        "Bash(python:*)"
        "Bash(python3:*)"
        "Bash(pip:*)"
        "Bash(pip3:*)"
        "Read(./.env)"
        "Read(./.env.*)"
        "Read(./secrets/**)"
        "Read(./config/credentials.json)"
        "Read(./build)"
      ];
      model = "opusplan";
    };
  };
}
