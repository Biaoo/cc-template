---
description: Deep verification of documentation consistency with current project state
allowed-tools: Glob, Read, Grep, Bash(git log:*), Bash(git diff:*), Bash(git show:*), Bash(find:*), Bash(ls:*), AskUserQuestion, Task
argument-hint: <file-or-path>
---

# Documentation Consistency Verification Command

You are tasked with deeply analyzing whether documentation is consistent with the current project state, including implementation progress, code, technical design, and other aspects.

## Context

**Target for verification:** `$1` (file or directory path)

**Recent project changes:** !`git log --oneline --all -20 2>/dev/null || echo "Not a git repository"`

**Current git branch:** !`git branch --show-current 2>/dev/null || echo "Not a git repository"`

**Modified files recently:** !`git diff --name-only HEAD~10..HEAD 2>/dev/null | head -20 || echo "Not available"`

## Your Mission

Perform a **deep consistency check** between the specified documentation and the actual project state. Identify conflicts, outdated information, and inconsistencies.

## Analysis Framework

### Phase 1: Document Understanding

First, thoroughly read and understand the target documentation:

1. **Read all specified files**
   - If `$1` is a file: read that specific file
   - If `$1` is a directory: find and read all markdown/text files in it
   - Parse the document structure and identify key claims

2. **Extract key claims and references**
   - Technical specifications mentioned
   - Implementation states described (e.g., "implemented", "planned", "in progress")
   - File paths and code references
   - API endpoints, functions, classes mentioned
   - Architecture diagrams or design decisions
   - Dependencies and versions
   - Configuration settings
   - Workflow descriptions

3. **Identify verification points**
   - What can be verified against actual code?
   - What can be verified against git history?
   - What requires cross-referencing with other docs?

### Phase 2: Project State Analysis

Gather current project state information:

1. **Code structure verification**
   - Find files/directories mentioned in documentation
   - Check if referenced code elements exist (classes, functions, variables)
   - Verify imports and dependencies
   - Check configuration files

2. **Implementation status verification**
   - Use git log to check when mentioned features were implemented
   - Check if "TODO" or "planned" features have been completed
   - Verify if "implemented" features actually exist in code

3. **Cross-document consistency**
   - Find related documentation files
   - Check for conflicting information across docs
   - Verify consistency in terminology and naming

4. **Recent changes impact**
   - Analyze recent commits that might affect documented areas
   - Check if recent refactoring invalidated documentation
   - Identify renamed/moved files that docs still reference

### Phase 3: Conflict Detection

For each verification point, categorize findings:

#### A. **Critical Conflicts** (High Priority)

- Documentation describes features/code that don't exist
- File paths that are incorrect or outdated
- API descriptions that don't match implementation
- Configuration examples that would fail
- Incorrect technical specifications

#### B. **Outdated Information** (Medium Priority)

- Features marked as "planned" that are now implemented
- Old file paths (files have moved)
- Deprecated APIs still documented as current
- Old version numbers or dependencies
- Outdated examples or screenshots

#### C. **Inconsistencies** (Medium Priority)

- Conflicting information across different docs
- Terminology inconsistencies
- Different naming conventions
- Contradictory design decisions

#### D. **Minor Issues** (Low Priority)

- Typos in code examples
- Minor formatting issues
- Dead links to external resources
- Missing optional details

### Phase 4: Evidence Collection

For each conflict found, provide:

1. **Location**: Exact file and line number in documentation
2. **Claim**: What the documentation states
3. **Reality**: What actually exists in the project
4. **Evidence**:
   - Code snippets showing the truth
   - Git log entries showing when things changed
   - File listings showing structure
5. **Impact**: How serious is this conflict?

## Verification Techniques

### Technique 1: Direct Code Verification

For code references in documentation:

```
1. Extract mentioned file paths → Check if files exist
2. Extract mentioned functions/classes → Grep for definitions
3. Extract code examples → Compare with actual implementation
4. Extract import statements → Verify they work
```

### Technique 2: Git History Analysis

For implementation status claims:

```
1. Find commits related to mentioned features
2. Check dates: is "recently added" actually recent?
3. Verify "TODO" items aren't already done
4. Check if mentioned changes were reverted
```

### Technique 3: Cross-Reference Check

For consistency across documents:

```
1. Find all docs mentioning the same topic
2. Extract key facts from each
3. Compare for contradictions
4. Check terminology consistency
```

### Technique 4: Dependency Verification

For technical specifications:

```
1. Check package.json / requirements.txt / go.mod etc.
2. Verify version numbers match documentation
3. Check if dependencies are actually used in code
4. Verify configuration files match documented settings
```

## Special Checks

### For API Documentation

- Verify endpoint paths exist in routes/controllers
- Check request/response formats against actual code
- Verify authentication requirements
- Test example curl commands (if safe)

### For Architecture Documentation

- Verify directory structure matches diagrams
- Check if documented modules/layers exist
- Verify data flow descriptions against code
- Check if design patterns are actually used

### For Setup/Installation Guides

- Verify commands are current and correct
- Check if referenced files/scripts exist
- Verify environment variables match code
- Check if steps are complete and in order

### For Workflow Documentation

- Verify scripts/commands mentioned exist
- Check if described processes match actual code
- Verify CI/CD configs match documentation
- Check if tools mentioned are actually used

## Output Format

Provide a comprehensive report:

```markdown
## Verification Summary

**Target:** [file or path verified]
**Verification Date:** [current date]
**Project State:** [git branch, recent commit]

### Quick Stats
- Total claims verified: X
- Critical conflicts found: X
- Outdated information: X
- Inconsistencies: X
- Minor issues: X
- ✅ Verified correct: X

---

## Critical Conflicts 🔴

### Conflict 1: [Brief description]

**Location:** `path/to/doc.md:line_number`

**Documentation states:**
```

[Exact quote from documentation]

```

**Actual state:**
```

[What actually exists - code snippet, file listing, etc.]

```

**Evidence:**
[Git log, grep results, file contents, etc.]

**Impact:** [Explain why this is critical]

**Recommended action:** [What should be updated]

---

[Repeat for each critical conflict]

---

## Outdated Information ⚠️

### Issue 1: [Brief description]

**Location:** `path/to/doc.md:line_number`

**Problem:** [Explanation]

**Current state:** [What's actually true now]

**Suggested update:** [Proposed fix]

---

[Repeat for each outdated item]

---

## Inconsistencies 📋

### Inconsistency 1: [Description]

**Conflicting sources:**
- Doc A (`path/a.md:line`): Says X
- Doc B (`path/b.md:line`): Says Y

**Resolution needed:** [Which is correct? Or reconcile both?]

---

## Minor Issues 📝

[List of minor issues with locations]

---

## Verified Correct ✅

[List of major claims that were verified as accurate]

---

## Recommendations

### Immediate Actions Required
1. [Priority 1 action]
2. [Priority 2 action]
...

### Proposed Documentation Updates
[Specific changes to make - present as diff-like format when possible]

### Preventive Measures
- [How to keep docs in sync going forward]
- [Automation opportunities]
- [Documentation policies]

---

## User Confirmation Required

[Use AskUserQuestion to confirm documentation updates]
```

## Execution Workflow

1. **Understand Target** (5 min)
   - Read specified documentation thoroughly
   - Build mental model of what it claims

2. **Gather Evidence** (10-15 min)
   - Use Task tool with Explore agent for complex code searches
   - Use Grep for finding code references
   - Use git commands for history
   - Read related files

3. **Analyze & Compare** (10 min)
   - Match documentation claims against reality
   - Categorize each finding by severity
   - Collect evidence for each conflict

4. **Report** (5 min)
   - Format findings clearly
   - Provide specific, actionable recommendations
   - Prepare update proposals

5. **Confirm & Update** (as needed)
   - Use AskUserQuestion for significant updates
   - Apply approved changes
   - Summarize what was fixed

## Guidelines

### Be Thorough

- Don't just check obvious things
- Read code, don't just grep for keywords
- Consider edge cases and implications
- Check both what's there and what's missing

### Be Specific

- Provide exact line numbers
- Quote exact text from docs
- Show actual code/files as proof
- Link to specific commits when relevant

### Be Practical

- Prioritize by impact, not just quantity
- Consider maintenance burden
- Suggest realistic fixes
- Think about root causes

### Use Tools Effectively

- Use **Task tool with Explore agent** for broad searches across codebase
- Use **Grep** for specific keyword/pattern searches
- Use **Read** for reading specific files you know about
- Use **Bash git commands** for history analysis
- Don't guess - verify everything

### Understand Context

- Consider project phase (early dev vs production)
- Factor in recent major changes
- Understand documentation audience
- Respect project conventions

## Example Analysis Pattern

```
Documentation claim: "User authentication is handled by the AuthService class in src/auth/AuthService.ts"

Verification steps:
1. Check if src/auth/AuthService.ts exists
2. If not, search for AuthService class elsewhere
3. If found elsewhere, check git log for when it moved
4. If not found at all, search for actual auth implementation
5. Compare actual implementation with documented description
6. Report findings with evidence

Result possibilities:
- ✅ File exists, class matches description
- ⚠️ File moved to different location (outdated path)
- 🔴 File doesn't exist, no AuthService found (critical conflict)
- ⚠️ File exists but implementation differs from description
```

## Important Notes

- **Use the Task tool** when you need to do broad exploration or complex multi-file searches
- **Be conservative**: Only propose updates when you have strong evidence
- **Request confirmation**: Always use AskUserQuestion before modifying documentation
- **Explain reasoning**: Help user understand why conflicts matter
- **Provide context**: Show git history when relevant to explain how things diverged

---

**Remember**: Your goal is to be a thorough documentation auditor. Find real issues, provide solid evidence, and propose concrete fixes. Be the bridge between what's documented and what's real.
