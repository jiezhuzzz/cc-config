# AGENTS.md

Guide for AI agents working in this Nix flake configuration repository.

## Overview

This is a **Nix flake configuration** repository managing system configurations across multiple platforms:

- **macOS** (Darwin) via nix-darwin
- **NixOS** desktops and servers
- **Home Manager** standalone configurations (servers, codespaces)

The repository uses the Nix language exclusively for configuration files (`.nix`).

## Essential Commands

### Apply Configurations

```bash
# macOS (Darwin)
darwin-rebuild switch --flake .#mac

# NixOS desktop
sudo nixos-rebuild switch --flake .#steamer

# NixOS NAS
sudo nixos-rebuild switch --flake .#nas

# Home Manager (standalone servers)
nix run nixpkgs#home-manager -- switch --flake .#<target>
# Targets: space (codespace), cc, orb, goku, vegeta
```

### Development

```bash
# Format Nix files (uses alejandra formatter)
nix fmt

# Update flake inputs
nix flake update

# Check flake validity
nix flake check
```

### Linting

The project uses `alejandra` as the Nix formatter. It's configured in `flake.nix`:
```nix
formatter = pkgs.alejandra;
```

## Code Organization

```
cc-config/
├── flake.nix           # Main entry point, defines all configurations
├── flake.lock          # Locked dependencies
├── apps/               # Modular application configurations
│   ├── dev/            # Development tools (git, helix, claude, etc.)
│   ├── prod/           # Production/shell tools (zsh, tmux, fzf, etc.)
│   ├── gui/            # GUI applications (zed, ghostty, vscode, etc.)
│   └── media/          # Media server applications
├── home-manager/       # Home Manager profiles
│   ├── shared.nix      # Common configuration for all hosts
│   ├── darwin.nix      # macOS-specific home config
│   ├── server.nix      # Linux server config
│   ├── codespace.nix   # GitHub Codespaces config
│   └── *.nix           # Other platform-specific configs
├── darwin/             # macOS system configuration (nix-darwin)
├── desktop/            # NixOS desktop configuration
├── nas/                # NixOS NAS server configuration
├── scripts/            # Shell scripts (packaged via writeShellScriptBin)
└── agents/             # AI agent configuration
    ├── rules/          # Agent rules (loaded always)
    └── skills/         # Agent skills (loaded on demand)
```

## Nix Conventions

### Module Pattern

Application modules in `apps/` follow a consistent pattern:

```nix
{pkgs, ...}: {
  programs.<name> = {
    enable = true;
    # configuration options
  };
}
```

Or for simple imports:
```nix
{
  programs.<name> = {
    enable = true;
    settings = { ... };
  };
}
```

### Importing Applications

Applications are imported through `apps/default.nix` which exports:
- `dev` - Development tools
- `prod` - Production/shell tools  
- `gui` - GUI applications
- `media` - Media applications

Usage in home-manager configs:
```nix
let
  apps = import ../apps;
  inherit (apps) dev prod gui;
in {
  imports = [
    dev.git
    prod.zsh
    gui.zed
  ];
}
```

### Custom Scripts

Shell scripts in `scripts/` are packaged using `writeShellScriptBin`:
```nix
home.packages = with pkgs; [
  (writeShellScriptBin "script-name" (builtins.readFile ../scripts/script.sh))
];
```

### Configuration Hierarchy

1. `flake.nix` - Entry point with `mkDarwinConfig`, `mkDesktopConfig`, etc.
2. Platform configs (`darwin/`, `desktop/`, `nas/`) - System-level settings
3. `home-manager/*.nix` - User environment configurations
4. `apps/**/*.nix` - Individual application configurations

### Catppuccin Theme

The repository uses Catppuccin (Frappé variant) theming across applications:
```nix
catppuccin.enable = true;
catppuccin.flavor = "frappe";
```

## Key Patterns

### Conditional Configuration

Use `lib.mkIf` for conditional settings:
```nix
{lib, config, ...}: {
  signing = lib.mkIf (!isCodespace) {
    format = "ssh";
    signByDefault = true;
  };
}
```

### XDG Base Directories

The configuration prefers XDG directories:
```nix
home.preferXdgDirectories = true;
xdg.enable = true;
```

### Shell Aliases

Common aliases defined in `home-manager/shared.nix`:
- `g` → `git`
- `v`, `vim`, `vi` → `nvim`
- `ls`, `ll`, `la`, `tree` → `eza` variants

### Default Editor

Helix (`hx`) is the default editor:
```nix
home.sessionVariables.EDITOR = "hx";
```

## Agent Rules

Rules in `agents/rules/` are always loaded. Current rules:

### Modern Unix Tools (`unix-tools.md`)

Use modern alternatives:
- `fd` instead of `find`
- `rg` (ripgrep) instead of `grep`
- `bat` instead of `cat`
- `eza` instead of `ls`
- `dust` instead of `du`
- `duf` instead of `df`
- `procs` instead of `ps`
- `bottom`/`btm` instead of `top`
- `sd` instead of `sed`
- `jaq` for JSON processing
- `xh` instead of `curl` for APIs

### Python (`python.md`)

Always use `uv` for Python:
- `uv run python script.py` - Run scripts
- `uv init --script example.py` - Create standalone scripts
- `uvx <tool>` - Run tools without installing (e.g., `uvx ruff check .`)

## Agent Permissions (Claude Code)

Configured in `apps/dev/claude.nix`:

**Allowed:**
- `ls *`, `* --version`, `* --help *`
- `git *`

**Denied:**
- `grep`, `find` (use modern alternatives)
- `python`, `python3`, `pip`, `pip3` (use `uv`)
- Reading `.env`, `.env.*`, `secrets/**`, `config/credentials.json`, `build/`

## Testing Changes

After modifying Nix files:

1. **Check syntax**: `nix flake check`
2. **Format**: `nix fmt`
3. **Build without switching**: `darwin-rebuild build --flake .#mac` (or equivalent)
4. **Apply**: Use the appropriate switch command for the target platform

## Gotchas

1. **Homebrew on macOS**: Managed via `nix-homebrew`, casks defined in `darwin/homebrew.nix`
2. **Unfree packages**: Enabled via `nixpkgs.config.allowUnfree = true`
3. **State versions**: Different for each platform (e.g., `home.stateVersion = "25.11"`)
4. **Backup handling**: Home Manager configured with `overwriteBackup = true` and `backupFileExtension = "old"`
5. **Flake updates**: Automated weekly via GitHub Actions (`.github/workflows/update-flake.yml`)

## CI/CD

- **Flake updates**: Weekly on Sundays via `update-flake.yml`
- Creates PRs with title "ci: update flake.lock"
- Requires manual merge

## Adding New Applications

1. Create `apps/<category>/<name>.nix` following the module pattern
2. Export from `apps/<category>/default.nix`
3. Import in appropriate home-manager config(s)
4. Run `nix fmt` and test with `nix flake check`
