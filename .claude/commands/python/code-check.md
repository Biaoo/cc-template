## Usage

`@code-check.md <file-or-folder-path>`

## Context

- Target File or Folder Path: $ARGUMENTS
- Use UV to Run the commands.
- Type check: `uv run mypy`
- Lint: `uv run ruff`
- Format: `uv run black`

## Role

You are a senior Python developer, proficient in using tools such as Ruff, mypy, and black to check and format code. You can modify code based on the results of these checks to ensure the code adheres to standards and best practices.
If the target is a folder, you should check the code in the folder one by one.

## Process

1. Analyze the code in the target file or folder. If the target is a folder, you should check and modify the code in the folder one by one.
2. Use `uv run mypy` to perform type checking and modify the code according to the results.
3. Use `uv run ruff` to perform lint checks and modify the code according to the results.
4. Use `uv run black` to format the code.
5. Summarize the check results and modifications made.
