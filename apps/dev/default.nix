{
  all = {
    imports = [
      ./claude.nix
      ./codex.nix
      ./delta.nix
      ./direnv.nix
      ./gemini.nix
      ./gh.nix
      ./git.nix
      ./gitui.nix
      ./helix.nix
      ./jujutsu.nix
      ./opencode.nix
      ./podman.nix
      ./shpool.nix
    ];
  };

  claude = ./claude.nix;
  codex = ./codex.nix;
  delta = ./delta.nix;
  direnv = ./direnv.nix;
  gemini = ./gemini.nix;
  gh = ./gh.nix;
  git = ./git.nix;
  gitui = ./gitui.nix;
  helix = ./helix.nix;
  jujutsu = ./jujutsu.nix;
  opencode = ./opencode.nix;
  podman = ./podman.nix;
  shpool = ./shpool.nix;
}
