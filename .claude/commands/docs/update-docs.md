---
description: Update and organize project documentation based on latest progress
allowed-tools: Glob, Read, Write, Edit, Bash(git status:*), Bash(git log:*), Bash(find:*), Bash(ls:*), AskUserQuestion
argument-hint: [docs-path]
---

# Documentation Update and Organization Command

You are tasked with updating and organizing a project's documentation to ensure it stays current and well-structured.

## Context

**Project location:** Current working directory or path specified in `$1`

**Recent git changes:** !`git log --oneline -10 2>/dev/null || echo "Not a git repository"`

**Git status:** !`git status -s 2>/dev/null || echo "Not a git repository"`

**All markdown files in project:** !`find . -type f -name "*.md" -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/vendor/*" -not -path "*/dist/*" -not -path "*/build/*" 2>/dev/null | head -50`

## Your Tasks

### 1. Document Discovery and Analysis

Scan all markdown files in the project and categorize them:

- **Active documentation**: Current, well-maintained docs (README, API docs, guides, etc.)
- **Reference materials**: Technical documentation about tools, frameworks, or methodologies
- **Temporary/outdated docs**: Files that may be obsolete, contain outdated information, or were temporary notes
- **Project configuration docs**: Files like CLAUDE.md, AGENTS.md, or other configuration documentation
- **Development notes**: Meeting notes, brainstorming docs, task lists that may be outdated
- **Root-level docs**: Identify markdown files in project root that should be moved to subdirectories (except README.md, CLAUDE.md, AGENTS.md, CONTRIBUTING.md, LICENSE, CHANGELOG.md)

### 2. Identify Documentation Issues

Check for:

- **Outdated content**: Information that conflicts with recent code changes (check git log)
- **Duplicate content**: Similar information spread across multiple files
- **Temporary files**: Draft notes, TODO files, meeting notes that are no longer relevant
- **Broken references**: Links to files that no longer exist or have moved
- **Version mismatches**: Documentation that references old versions or deprecated features
- **Incomplete documentation**: Stub files or placeholders that were never completed
- **Root directory clutter**: Non-essential markdown files in project root that should be moved to subdirectories

### 3. Propose Organization Structure

Based on the project type, suggest organizing documentation into:

**Core Principle: Keep Project Root Clean**

The project root directory should contain **only essential files**:

- ✅ `README.md` - Project overview
- ✅ `CLAUDE.md` / `AGENTS.md` - AI assistant configuration
- ✅ `CONTRIBUTING.md` - Contribution guidelines
- ✅ `LICENSE` - License file
- ✅ `CHANGELOG.md` - Version history (if applicable)

**All other documentation** should be organized into subdirectories:

**Common structure:**

```
docs/                    # Main documentation directory
├── guides/             # User guides and tutorials
├── api/                # API documentation
├── references/         # Technical reference materials
├── development/        # Development guides and notes
└── archive/            # Outdated but historically relevant docs
```

**For specific project types:**

- **Library/Framework**: API docs, usage examples, migration guides
- **Application**: User guides, deployment docs, configuration
- **Monorepo**: Per-package docs with shared guidelines

### 4. Recommend Updates to Configuration Files

Review whether any content should be added to:

- **AGENTS.md**: Project-level instructions for AI Coding Assistant (if exists)
- **CLAUDE.md**: The same as AGENTS.md (if exists, may be symbolic link to AGENTS.md)
- **README.md**: Project overview and getting started
- **CONTRIBUTING.md**: Development workflow and guidelines

**IMPORTANT**: Use `AskUserQuestion` to confirm before:

- Creating or modifying CLAUDE.md or AGENTS.md
- Adding content to README.md or CONTRIBUTING.md
- Moving files to new locations
- Deleting any files
- Creating new directory structure

### 5. Handle Technical Reference Documents

For technical reference materials (guides about external tools, frameworks, best practices):

1. **Identify stable references**: Documentation that doesn't change with project evolution
2. **Propose consolidation**: Move to a dedicated `references/` or `docs/references/` directory
3. **Ensure consistent naming**: Use clear, descriptive names (e.g., `docker-best-practices.md`, `typescript-style-guide.md`)
4. **Update cross-references**: Fix links when moving files

### 6. Clean Up Outdated Content

Identify and propose handling of:

- **Obsolete files**: Documentation for removed features
- **Temporary notes**: Meeting notes, brainstorming sessions older than 3 months
- **Duplicate content**: Files with overlapping information
- **Draft files**: Incomplete documents that were never finalized

**Options for handling:**

- Move to `archive/` or `docs/archive/` directory
- Delete if truly no longer needed (with user confirmation)
- Consolidate into more comprehensive documents

### 7. Generate Summary Report

Provide a comprehensive report including:

#### A. Document Inventory

- Total markdown files found
- Files categorized by type
- Files categorized by status (active/outdated/temporary)

#### B. Issues Identified

- Outdated content with specific examples
- Duplicate or redundant files
- Broken references
- Missing critical documentation

#### C. Proposed Changes

- Files to move/rename (with rationale)
- Files to archive or delete (with confirmation)
- Content to add to configuration files (with confirmation)
- New directory structure (if needed)

#### D. Recommendations

- Documentation gaps to fill
- Suggested maintenance procedures
- Tools or automation opportunities
- Style and consistency improvements

## Execution Workflow

1. **Discover**: Find and read all markdown files
2. **Analyze**: Categorize and identify issues
3. **Propose**: Present findings and suggested changes
4. **Confirm**: Use AskUserQuestion for all significant changes
5. **Execute**: Make approved changes
6. **Report**: Summarize what was done

## Guidelines

- **Default to preservation**: When uncertain, keep files and ask the user
- **Respect project conventions**: Follow existing naming and organizational patterns
- **Maintain git history**: Don't delete files that have significant git history without confirmation
- **Check dependencies**: Before moving/deleting, search for references in code and docs
- **Update cross-references**: Fix all links when reorganizing
- **Document your changes**: Explain reasoning for each change
- **Be thorough**: Read file contents, don't just rely on filenames
- **Context matters**: Consider recent git changes when identifying outdated content
- **Keep root directory clean**: Project root should primarily contain essential files only (README.md, CLAUDE.md, AGENTS.md, CONTRIBUTING.md, LICENSE, etc.). Move other documentation to organized subdirectories like `docs/`, `references/`, or appropriate category folders

## Special Considerations

### For CLAUDE.md/AGENTS.md Updates

When proposing additions to CLAUDE.md or AGENTS.md:

- Only suggest if there's clear project-wide guidance worth documenting
- Present the proposed text for user review
- Explain why this belongs in configuration vs. regular docs

### For Project-Specific Patterns

Detect and respect existing patterns:

- Documentation location conventions
- Naming styles (kebab-case, snake_case, etc.)
- Directory structure
- Link reference styles

### For Archived Content

When archiving instead of deleting:

- Create `archive/` or `docs/archive/` directory
- Add a note to archived files explaining why they were archived
- Update any remaining references to indicate the file is archived

## Output Format

Structure your response as:

```
## Document Analysis

### Files Found
[Categorized list of all markdown files]

### Issues Identified
[Specific problems found with examples]

---

## Proposed Changes

### File Organization
[Files to move, with before/after paths]

### Content Updates
[Proposed additions to configuration files - REQUIRES CONFIRMATION]

### Cleanup Actions
[Files to archive/delete - REQUIRES CONFIRMATION]

---

## Confirmation Required

[List of all actions requiring user approval with AskUserQuestion]

---

## Executed Changes

[After confirmation, list what was actually changed]

---

## Recommendations

### Documentation Gaps
[Missing docs that should be created]

### Maintenance Suggestions
[Ongoing maintenance recommendations]

### Quality Improvements
[Style, consistency, and structure improvements]
```

---

**Remember**:

- This command works on ANY project, not just the prompts repository
- Always request confirmation before structural changes or deletions
- Be thorough in analysis but conservative in execution
- Prioritize user communication and transparency
