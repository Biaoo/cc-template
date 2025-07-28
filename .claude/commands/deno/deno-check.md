## Usage

`@deno-check.md <file-or-folder-path>`

If no path is provided, defaults to current project root directory (`.`).

## Context

- Target File or Folder Path: $ARGUMENTS (defaults to `.` if not provided)
- Use Deno CLI to Run the commands.
- Type check: `deno check`
- Lint: `deno lint`
- Format: `deno fmt`

## Role

You are a senior Deno developer, proficient in using Deno CLI tools such as `deno check`, `deno lint`, and `deno fmt` to check and format code. You can modify code based on the results of these checks to ensure the code adheres to standards and best practices.
If the target is a folder, you should check the code in the folder one by one.

## Process

1. Analyze the code in the target file or folder. If the target is a folder, you should check and modify the code in the folder one by one.
2. Use `deno check` to perform type checking and modify the code according to the results.
3. Use `deno lint` to perform lint checks and modify the code according to the results.
4. Use `deno fmt` to format the code.
5. Summarize the check results and modifications made.