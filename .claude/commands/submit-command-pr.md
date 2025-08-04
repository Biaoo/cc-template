Submit a new command as a PR to the remote repository's .claude/commands directory, following the steps:

```shell
#!/bin/bash

# Submit a new command file as a PR to the remote repository
# Target: https://github.com/Biaoo/cc-template.git

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REMOTE_REPO="https://github.com/Biaoo/cc-template.git"
UPSTREAM_OWNER="Biaoo"
UPSTREAM_REPO="cc-template"
COMMANDS_DIR=".claude/commands"

# Check if command file argument is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: Please provide the command file to submit${NC}"
    echo -e "Usage: $0 <command-file.md> [pr-title]"
    echo -e "Example: $0 my-command.md \"Add new deployment command\""
    exit 1
fi

COMMAND_FILE="$1"
PR_TITLE="${2:-Add new command: $(basename "$COMMAND_FILE")}"

# Validate the command file exists
if [ ! -f "$COMMAND_FILE" ]; then
    echo -e "${RED}Error: File '$COMMAND_FILE' not found${NC}"
    exit 1
fi

# Validate file is a markdown file
if [[ ! "$COMMAND_FILE" =~ \.md$ ]]; then
    echo -e "${YELLOW}Warning: Command file should be a .md file${NC}"
fi

COMMAND_FILENAME=$(basename "$COMMAND_FILE")
BRANCH_NAME="add-command-$(echo "$COMMAND_FILENAME" | sed 's/\.md$//' | tr ' ' '-')-$(date +%s)"

echo -e "${YELLOW}Starting PR submission process...${NC}"

# Create temporary directory for work
TEMP_DIR=$(mktemp -d)
echo -e "Working directory: $TEMP_DIR"

# Clone the repository
echo -e "${BLUE}Cloning repository...${NC}"
git clone "$REMOTE_REPO" "$TEMP_DIR" 2>/dev/null

cd "$TEMP_DIR"

# Configure git (using generic values if not already configured)
git config user.name "$(git config --global user.name || echo 'Command Contributor')"
git config user.email "$(git config --global user.email || echo 'contributor@example.com')"

# Create new branch
echo -e "${BLUE}Creating branch: $BRANCH_NAME${NC}"
git checkout -b "$BRANCH_NAME"

# Ensure commands directory exists
mkdir -p "$COMMANDS_DIR"

# Copy the command file
echo -e "${BLUE}Adding command file: $COMMANDS_DIR/$COMMAND_FILENAME${NC}"
cp "$OLDPWD/$COMMAND_FILE" "$COMMANDS_DIR/$COMMAND_FILENAME"

# Stage and commit the changes
git add "$COMMANDS_DIR/$COMMAND_FILENAME"

# Create commit message
COMMIT_MSG="feat: add $COMMAND_FILENAME command

- Add new command file to $COMMANDS_DIR
- Command provides: $(head -n 1 "$COMMANDS_DIR/$COMMAND_FILENAME" | sed 's/^#*\s*//')"

git commit -m "$COMMIT_MSG"

echo -e "${GREEN}✓ Changes committed successfully${NC}"

# Check if gh CLI is available
if ! command -v gh &> /dev/null; then
    echo -e "${RED}GitHub CLI (gh) is not installed${NC}"
    echo -e "${YELLOW}Please install gh to automatically create the PR:${NC}"
    echo -e "  brew install gh (macOS)"
    echo -e "  Or visit: https://cli.github.com/"
    echo -e ""
    echo -e "${YELLOW}Manual steps to create PR:${NC}"
    echo -e "1. Fork the repository: $REMOTE_REPO"
    echo -e "2. Add your fork as remote and push:"
    echo -e "   git remote add fork YOUR_FORK_URL"
    echo -e "   git push fork $BRANCH_NAME"
    echo -e "3. Create PR via GitHub web interface"
    echo -e ""
    echo -e "Your changes are saved in: $TEMP_DIR"
    echo -e "Branch name: $BRANCH_NAME"
    exit 0
fi

# Check if authenticated with gh
if ! gh auth status &> /dev/null; then
    echo -e "${YELLOW}Not authenticated with GitHub CLI${NC}"
    echo -e "Run: gh auth login"
    echo -e ""
    echo -e "Your changes are saved in: $TEMP_DIR"
    echo -e "Branch name: $BRANCH_NAME"
    exit 0
fi

# Fork the repository if not already forked
echo -e "${BLUE}Checking/creating fork...${NC}"
gh repo fork "$UPSTREAM_OWNER/$UPSTREAM_REPO" --clone=false || true

# Get the fork URL
FORK_OWNER=$(gh api user --jq .login)
FORK_URL="https://github.com/$FORK_OWNER/$UPSTREAM_REPO.git"

# Add fork as remote and push
echo -e "${BLUE}Pushing to fork...${NC}"
git remote add fork "$FORK_URL"
git push fork "$BRANCH_NAME"

# Create PR
echo -e "${BLUE}Creating pull request...${NC}"

PR_BODY="## Summary
This PR adds a new command file: \`$COMMAND_FILENAME\`

## Changes
- Added \`$COMMANDS_DIR/$COMMAND_FILENAME\`

## Description
$(head -n 5 "$COMMANDS_DIR/$COMMAND_FILENAME" | grep -v '^```' | sed 's/^#*\s*//')

## Testing
- [ ] Command file follows the existing format
- [ ] Command has been tested locally
- [ ] Documentation is clear and complete"

PR_URL=$(gh pr create \
    --repo "$UPSTREAM_OWNER/$UPSTREAM_REPO" \
    --head "$FORK_OWNER:$BRANCH_NAME" \
    --title "$PR_TITLE" \
    --body "$PR_BODY" \
    2>/dev/null)

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Pull request created successfully!${NC}"
    echo -e "${GREEN}PR URL: $PR_URL${NC}"
else
    echo -e "${YELLOW}Pull request may already exist or there was an error${NC}"
    echo -e "You can create it manually at: https://github.com/$UPSTREAM_OWNER/$UPSTREAM_REPO/pulls"
fi

# Clean up
cd - > /dev/null
rm -rf "$TEMP_DIR"

echo -e "${GREEN}✓ Process completed!${NC}"
```

## Requirements

- Git installed and configured with user.name and user.email
- GitHub CLI (`gh`) installed and authenticated for automatic PR creation
- Write access to fork the repository

## What this command does

1. Validates the command file exists and is accessible
2. Creates a temporary working directory
3. Clones the target repository
4. Creates a new branch with a unique name
5. Adds your command file to `.claude/commands/`
6. Commits the changes with a descriptive message
7. If GitHub CLI is available:
   - Forks the repository (if needed)
   - Pushes to your fork
   - Creates a pull request automatically
8. If GitHub CLI is not available:
   - Provides manual instructions for creating the PR

## Notes

- The command file should follow the same format as existing commands
- Make sure your command is well-documented and tested
- The PR will be created against the main branch of the upstream repository
- You need to have GitHub CLI installed and authenticated for automatic PR creation
