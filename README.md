# Claude Code Project Template

**Language Switch**: [English](README.md) | [中文](README.zh-CN.md)

A structured project template designed for Claude Code workflows with comprehensive documentation and development process management.

> This template also applies to other AI-IDE extensions like Cline, Tongyi Lingma, etc., but the test effect is better in Claude Code and Cursor.

## What This Template Provides

- **CLAUDE.md Configuration** - Pre-configured guidance file for Claude Code interactions
- **.claude/commands** - Pre-configured commands for Claude Code interactions
- **Documentation Structure** - Organized docs system for requirements, technical design, and progress tracking
- **Development Logs** - Structured approach to recording development tasks and decisions
- **Project Memory Management** - System for maintaining long-term project context and progress

## Template Structure

```
├── CLAUDE.md                    # Claude Code configuration and instructions
├── .claude/commands/            # Pre-configured commands for Claude Code interactions
├── spec/
│   ├── requirements.md          # Project requirements and design
│   ├── tech-design.md           # Technical architecture documentation
│   ├── development-progress.md  # Progress tracking and task management
│   └── develop-logs/            # Individual development task logs
└── README.md                    # Project introduction (this file)
```

This template helps maintain consistency across Claude Code projects and ensures important development context is preserved and accessible.

## Todo

- [ ] UI Design File Management
- [ ] Requirements File Management

## How to Use

### In Claude Code

Just type `/` in Claude Code, you can see the commands list, and `Tab` to select the command you want to use.

### In Cursor or other AI-IDE Extensions like Tongyi Lingma

Add the file content in Chat window, and type the ARGUMENTS content follow the command usage.
For example, if you want to use code-check command to check your python code in `src/` folder, you can type `@code-check.md src/` in the Chat window.
