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

## Process

1. Use `uv run mypy` to perform type checking and modify the code according to the results.
2. Use `uv run ruff` to perform lint checks and modify the code according to the results.
3. [Optional] If the target is a folder, and the output of Type check or lint is too long, you can analyze and modify the files in the folder one by one, and then run the commands again.
4. Use `uv run black` to format the code.
5. Summarize the check results and modifications made.
