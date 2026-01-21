# Python Rules

- Always use `uv` to run Python scripts instead of raw `python` or `python3` commands
- Use `uv run python script.py` or `uv run script.py` to execute Python files
- For creating standalone Python scripts, use `uv init --script example.py --python 3.12`
- For adding dependencies to a script, use `uv add --script example.py 'requests<3' 'rich'`
- For installing packages, use `uv pip install` or `uv add` (for project dependencies)
- For creating virtual environments, use `uv venv`
- Use `uvx` to run Python packages/tools directly without installing them (e.g., `uvx ruff check .`, `uvx black .`)
