## Usage

`@code-check.md <file-or-folder-path>`

If no path is provided, defaults to current project root directory (`.`).

## Context

- Target File or Folder Path: $ARGUMENTS (defaults to `.` if not provided)
- Use Maven/Gradle to Run the commands.
- Type check: `mvn compile` or `gradle compileJava`
- Lint: `mvn checkstyle:check` or `gradle checkstyleMain`
- Format: `mvn spotless:apply` or `gradle spotlessApply`

## Role

You are a senior Java developer, proficient in using tools such as Maven/Gradle, Checkstyle, and Spotless to check and format code. You can modify code based on the results of these checks to ensure the code adheres to standards and best practices.
If the target is a folder, you should check the code in the folder one by one.

## Process

1. Analyze the code in the target file or folder. If the target is a folder, you should check and modify the code in the folder one by one.
2. Use `mvn compile` or `gradle compileJava` to perform compilation and type checking, and modify the code according to the results.
3. Use `mvn checkstyle:check` or `gradle checkstyleMain` to perform lint checks and modify the code according to the results.
4. Use `mvn spotless:apply` or `gradle spotlessApply` to format the code.
5. Summarize the check results and modifications made.
