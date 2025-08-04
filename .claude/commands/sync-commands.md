Sync Claude Commands From Remote Repo, following the steps:

```shell
#!/bin/bash

# Sync .claude/commands from remote repository
# Source: https://github.com/Biaoo/cc-template.git

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REMOTE_REPO="https://github.com/Biaoo/cc-template.git"
TEMP_DIR=$(mktemp -d)
TARGET_DIR=".claude/commands"

echo -e "${YELLOW}Starting sync of $TARGET_DIR from remote repository...${NC}"

# Clone the repository to temporary directory (sparse checkout)
echo -e "Cloning repository to temporary directory..."
git clone --depth 1 --filter=blob:none --sparse "$REMOTE_REPO" "$TEMP_DIR" 2>/dev/null

cd "$TEMP_DIR"
git sparse-checkout set "$TARGET_DIR"

# Check if the commands directory exists in the remote repo
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}Error: $TARGET_DIR not found in remote repository${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Go back to original directory
cd - > /dev/null

# Backup existing commands directory if it exists
if [ -d "$TARGET_DIR" ]; then
    BACKUP_DIR="${TARGET_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}Backing up existing $TARGET_DIR to $BACKUP_DIR${NC}"
    mv "$TARGET_DIR" "$BACKUP_DIR"
fi

# Copy the commands directory from temp to current project
echo -e "Copying $TARGET_DIR to current project..."
cp -r "$TEMP_DIR/$TARGET_DIR" "$(dirname "$TARGET_DIR")"

# Clean up temporary directory
rm -rf "$TEMP_DIR"

echo -e "${GREEN}✓ Successfully synced $TARGET_DIR from $REMOTE_REPO${NC}"
echo -e "${GREEN}Files synced:${NC}"
find "$TARGET_DIR" -type f -name "*.md" | while read -r file; do
    echo -e "  - $file"
done
```
