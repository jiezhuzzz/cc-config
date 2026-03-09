---
name: fd-find
description: Use when finding files, listing directories, searching by filename patterns, filtering by type/size/time, or executing batch operations on files. Prefer fd over Glob, Grep, find, and ls for file discovery tasks. Auto-invoke on any file search need.
---

# fd — Fast File Finder

## Core Rule

**Always prefer `fd` over `find`, `ls -R`, Glob, and Grep for file discovery.** Run fd via the Bash tool. fd is faster, has saner defaults, and simpler syntax than find.

Key defaults: smart case, ignores hidden files, respects .gitignore. Use `-H` for hidden, `-I` for ignored, `-u` for both.

## Quick Reference

### Search Modes

| Flag | Purpose | Example |
|------|---------|---------|
| *(default)* | Regex on filename | `fd '^x.*rc$'` |
| `-g, --glob` | Glob pattern | `fd -g '*.py'` |
| `-F, --fixed-strings` | Literal substring | `fd -F 'config'` |
| `-p, --full-path` | Match against full path | `fd -p '/src/.*test'` |
| `--and <pat>` | Additional required pattern | `fd foo --and bar` |

### Visibility & Ignore

| Flag | Purpose |
|------|---------|
| `-H, --hidden` | Include hidden files/dirs (dotfiles) |
| `-I, --no-ignore` | Don't respect .gitignore/.fdignore |
| `-u, --unrestricted` | Alias for `-H -I` (use twice `-uu` for full unrestricted) |
| `-E, --exclude <glob>` | Exclude matching entries (repeatable) |
| `--ignore-contain <name>` | Skip directories containing this file |

### Case Sensitivity

| Flag | Purpose |
|------|---------|
| *(default)* | Smart case: insensitive unless pattern has uppercase |
| `-s, --case-sensitive` | Force case-sensitive |
| `-i, --ignore-case` | Force case-insensitive |

### Type Filtering

| Flag | Values |
|------|--------|
| `-t, --type` | `f`/file, `d`/dir, `l`/symlink, `x`/executable, `e`/empty, `s`/socket, `p`/pipe, `c`/char-device, `b`/block-device |
| `-e, --extension` | Filter by extension (repeatable): `-e rs -e toml` |
| `-S, --size` | Size filter: `+100m` (>100MB), `-1k` (<=1KB). Units: b/k/m/g/t/ki/mi/gi/ti |
| `-o, --owner` | Owner filter (unix): `user:group`, `!user`, `:group` |

### Depth Control

| Flag | Purpose |
|------|---------|
| `-d, --max-depth <n>` | Maximum search depth |
| `--min-depth <n>` | Minimum search depth |
| `--exact-depth <n>` | Exact depth only |

### Time Filtering

| Flag | Purpose | Example |
|------|---------|---------|
| `--changed-within <dur>` | Modified more recently than | `--changed-within 2weeks`, `--changed-within '2024-01-01'` |
| `--changed-before <dur>` | Modified before | `--changed-before 30d` |

Aliases: `--newer`, `--changed-after`, `--older`, `--change-older-than`

### Output

| Flag | Purpose |
|------|---------|
| `-a, --absolute-path` | Show absolute paths |
| `-l, --list-details` | Long listing (like `ls -l`) |
| `-0, --print0` | Null-separated output (for xargs -0) |
| `-c, --color <when>` | auto/always/never |
| `--format <fmt>` | Custom output format using placeholders |
| `--max-results <n>` | Limit number of results |
| `-1` | Single result only |
| `-q, --quiet` | No output, exit code 0 if match found |

### Command Execution

| Flag | Purpose |
|------|---------|
| `-x, --exec <cmd>` | Run command per result (parallel) |
| `-X, --exec-batch <cmd>` | Run command once with all results as args |
| `-j, --threads <n>` | Number of parallel threads (use `--threads=1` for serial) |
| `--batch-size <n>` | Max args per -X batch |

### Misc

| Flag | Purpose |
|------|---------|
| `-L, --follow` | Follow symlinks |
| `--prune` | Don't descend into matching dirs |
| `--one-file-system` | Don't cross filesystem boundaries |
| `-C, --base-directory <path>` | Change working directory |
| `--search-path <path>` | Alternative to positional path arg |
| `--path-separator <sep>` | Custom path separator |

## Placeholder Syntax (for -x and -X)

| Placeholder | Meaning | Example for `docs/images/photo.jpg` |
|-------------|---------|--------------------------------------|
| `{}` | Full path | `docs/images/photo.jpg` |
| `{/}` | Basename | `photo.jpg` |
| `{//}` | Parent directory | `docs/images` |
| `{.}` | Path without extension | `docs/images/photo` |
| `{/.}` | Basename without extension | `photo` |

Terminate command template with `\;` if adding more fd options after it.

## Common Patterns

```bash
# Find files by extension
fd -e rs
fd -e ts -e tsx

# Find files by name pattern (glob)
fd -g 'test_*.py'
fd -g '*.config.js'

# Find directories only
fd -t d node_modules
fd -t d -d 1   # top-level dirs only

# Find empty files/dirs
fd -t e -t f   # empty files
fd -t e -t d   # empty dirs

# Find large files
fd -t f -S +100m

# Find recently modified files
fd -t f --changed-within 1d
fd -t f --changed-within 2hours

# Find and execute (parallel)
fd -e zip -x unzip
fd -e h -e cpp -x clang-format -i
fd -e jpg -x convert {} {.}.png

# Find and execute (batch)
fd -g 'test_*.py' -X vim
fd -e rs -X wc -l
fd -e cpp -e h -X rg 'std::cout'

# List with details
fd -e rs -l

# Delete matching files
fd -H '^\.DS_Store$' -t f -X rm
fd -g '*.bak' -X rm

# Search everything (including hidden + ignored)
fd -u pattern

# Search specific directory
fd pattern /path/to/dir

# Find files without extension
fd '^[^.]+$'

# Checksums in parallel
fd -t f -x md5sum > checksums.txt
```

## Integration Patterns

```bash
# Pipe to fzf
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'

# Pipe to tree
fd --extension rs | tree --fromfile

# Pipe to xargs (null-separated for safety)
fd -0 -e rs | xargs -0 wc -l

# Feed to ripgrep (search within file class)
fd -e cpp -e h -X rg 'pattern'

# Count files by type
fd -e py | wc -l
```

## Gotchas

- **Smart case:** `fd foo` is case-insensitive, `fd Foo` is case-sensitive
- **Hidden files skipped by default:** Use `-H` to include dotfiles
- **.gitignore respected by default:** Use `-I` to include ignored files
- **Shell escaping:** Quote regex patterns with single quotes: `fd '^[A-Z]'`
- **Dash patterns:** Use `--` before patterns starting with `-`: `fd -- '-pattern'`
- **Aliases/functions:** Can't use shell aliases with `-x`/`-X` — use scripts or `bash -c`
- **Filename only by default:** Use `-p` to match against full path
- **.fdignore:** Like .gitignore but fd-specific. Global ignore at `~/.config/fd/ignore`
