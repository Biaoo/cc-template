## Usage

`@code-check.md <file-or-folder-path>`

If no path is provided, defaults to current project root directory (`.`).

## Context

- Target File or Folder Path: $ARGUMENTS (defaults to `.` if not provided)
- Use UV to Run the commands.
- Type check: `uv run mypy`, use `> .mypy/<output_file_name>.txt` to save the output to a file.
- Ruff fix: `uv run ruff fix <file-or-folder-path> --safe` to fix the code.
- Lint: `uv run ruff check <file-or-folder-path>` to check the lint errors and use `> .ruff/<output_file_name>.txt` to save the output to a file.
- Format: `uv run black`

## Role

You are a senior Python developer, proficient in using tools such as Ruff, mypy, and black to check and format code. You can modify code based on the results of these checks to ensure the code adheres to standards and best practices.
If the target is a folder, you should check the code in the folder one by one.

## Process

1. Analyze the code in the target file or folder. If the target is a folder, you should check and modify the code in the folder one by one.
2. Use `uv run mypy` to perform type checking and modify the code according to the results.
3. Use `uv run ruff fix <file-or-folder-path> --safe` to fix the code.
4. Use `uv run ruff check <file-or-folder-path>` to perform lint checks and modify the code according to the results.
5. Use `uv run black` to format the code.
6. Summarize the check results and modifications made.
