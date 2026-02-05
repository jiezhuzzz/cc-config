# Modern Unix Tools Rules

This machine installed modern Unix tools, use them for better performance and output.

## File Search and Text Search
- Use `fd` instead of `find` for finding files (e.g., `fd pattern` instead of `find . -name pattern`)
- Use `ripgrep` (rg) instead of `grep` for searching file contents (e.g., `rg pattern` instead of `grep -r pattern`)

## File Viewing and Navigation
- Use `bat` instead of `cat` for viewing files with syntax highlighting (e.g., `bat file.txt`)
- Use `eza` or `exa` instead of `ls` for better file listings with colors and icons (e.g., `eza -la`)

## System Monitoring
- Use `dust` instead of `du` for disk usage analysis (e.g., `dust` instead of `du -sh`)
- Use `duf` instead of `df` for disk free space with better formatting
- Use `procs` instead of `ps` for process listing with better output (e.g., `procs` instead of `ps aux`)
- Use `bottom` or `btm` instead of `top`/`htop` for system monitoring

## Text Processing
- Use `sd` instead of `sed` for simple text replacements (e.g., `sd 'old' 'new' file.txt`)
- Use `jaq` for JSON processing instead of complex grep/sed combinations
- Use `xh` instead of `curl` for API requests when better formatting is needed
