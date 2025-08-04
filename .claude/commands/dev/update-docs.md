## Usage

`@update-docs.md <update-target>`

## Context

- Update Target: $ARGUMENTS
- Development Progress: `@spec/development-progress.md`
- Requirement Design: `@spec/requirements.md`
- Tech Design: `@spec/tech-design.md`

## Process

Analyze the relevant information in the current documents based on the user's requested update target, propose a reasonable design plan according to the task objective, and update the corresponding design and development documents.

If it is a new development requirement or iteration requirement, update @spec/requirements.md and @spec/tech-design.md. And add a new task in @spec/development-progress.md.

If it is a bug fix or improvement, update @spec/tech-design.md and @spec/development-progress.md.
