#!/bin/bash

# Add Claude Config from Template Repository
# This script should be run in the target project to add claude configuration as submodule
# Usage: curl -sSL https://raw.githubusercontent.com/Biaoo/my-cc-template/main/add-claude-config.sh | bash
# Or: wget -O- https://raw.githubusercontent.com/Biaoo/my-cc-template/main/add-claude-config.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
TEMPLATE_REPO="https://github.com/Biaoo/cc-template.git"
SUBMODULE_NAME=".claude-template"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [submodule-name]"
    echo ""
    echo "Arguments:"
    echo "  submodule-name      Optional. Name for submodule directory (default: .claude-template)"
    echo ""
    echo "This script must be run in the root of your target project."
    echo ""
    echo "Examples:"
    echo "  $0                    # Use default name .claude-template"
    echo "  $0 claude-config      # Use custom name claude-config"
}

# Parse arguments
if [ $# -gt 1 ]; then
    print_error "Too many arguments"
    show_usage
    exit 1
fi

SUBMODULE_NAME="${1:-$SUBMODULE_NAME}"

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    print_error "This directory is not a git repository"
    print_error "Please run this script in the root of your git project"
    exit 1
fi

print_status "Adding Claude configuration from template repository..."
print_status "Template repository: $TEMPLATE_REPO"
print_status "Submodule name: $SUBMODULE_NAME"
print_status "Current directory: $(pwd)"

# Step 1: Check if submodule already exists
if [ -d "$SUBMODULE_NAME" ]; then
    print_warning "Submodule directory '$SUBMODULE_NAME' already exists"
    
    # Check if it's already a submodule
    if git submodule status "$SUBMODULE_NAME" >/dev/null 2>&1; then
        print_status "Found existing submodule, updating it..."
        if git submodule update --init --recursive "$SUBMODULE_NAME"; then
            print_success "Existing submodule updated successfully"
        else
            print_error "Failed to update existing submodule"
            exit 1
        fi
    else
        print_error "Directory '$SUBMODULE_NAME' exists but is not a submodule"
        read -p "Do you want to remove it and add as submodule? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Remove from git index first, then remove directory
            git rm -r --cached "$SUBMODULE_NAME" 2>/dev/null || true
            rm -rf "$SUBMODULE_NAME"
            print_status "Removed existing directory and git index entry"
        else
            print_error "Cannot proceed with existing directory"
            exit 1
        fi
    fi
fi

# Add submodule if it doesn't exist
if [ ! -d "$SUBMODULE_NAME" ]; then
    print_status "Adding submodule..."
    
    # Try to add submodule
    if git submodule add "$TEMPLATE_REPO" "$SUBMODULE_NAME"; then
        print_success "Submodule added successfully"
    else
        print_warning "Failed to add submodule normally, trying to clean git state..."
        
        # Clean up any remnants in git
        git rm -r --cached "$SUBMODULE_NAME" 2>/dev/null || true
        git config --file .gitmodules --remove-section "submodule.$SUBMODULE_NAME" 2>/dev/null || true
        git config --remove-section "submodule.$SUBMODULE_NAME" 2>/dev/null || true
        
        # Try again
        if git submodule add "$TEMPLATE_REPO" "$SUBMODULE_NAME"; then
            print_success "Submodule added successfully after cleanup"
        else
            print_error "Failed to add submodule even after cleanup"
            print_error "Please manually run: git rm -r --cached $SUBMODULE_NAME"
            exit 1
        fi
    fi
fi

# Step 2: Configure sparse-checkout
print_status "Configuring sparse-checkout for .claude directory only..."
cd "$SUBMODULE_NAME"

# Enable sparse-checkout
git config core.sparseCheckout true

# Configure to only include .claude directory
echo ".claude/*" > .git/info/sparse-checkout

# Apply sparse-checkout
if git read-tree -m -u HEAD; then
    print_success "Sparse-checkout configured - only .claude directory will be checked out"
else
    print_error "Failed to apply sparse-checkout"
    exit 1
fi

# Go back to project root
cd ..

# Step 3: Choose setup method
print_status "Choose how to setup .claude directory:"
echo "1) Create symbolic link (recommended - stays synced with template)"
echo "2) Copy files (independent copy - you can modify freely)"
read -p "Enter your choice (1/2): " -n 1 -r
echo

case $REPLY in
    1)
        # Create symbolic link
        print_status "Creating symbolic link to .claude directory..."
        if [ -e ".claude" ]; then
            print_warning ".claude already exists in current project"
            read -p "Do you want to backup and replace it? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                mv .claude .claude.backup.$(date +%Y%m%d_%H%M%S)
                print_status "Existing .claude backed up"
            else
                print_warning "Skipping symbolic link creation"
                print_success "Setup completed without symbolic link"
                print_status "You can manually create the link later with:"
                print_status "  ln -s $SUBMODULE_NAME/.claude .claude"
                exit 0
            fi
        fi

        # Create symbolic link
        if ln -s "$SUBMODULE_NAME/.claude" .claude; then
            print_success "Symbolic link created: .claude -> $SUBMODULE_NAME/.claude"
        else
            print_error "Failed to create symbolic link"
            exit 1
        fi
        ;;
    2)
        # Copy files
        print_status "Copying .claude directory..."
        if [ -e ".claude" ]; then
            print_warning ".claude already exists in current project"
            read -p "Do you want to backup and replace it? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                mv .claude .claude.backup.$(date +%Y%m%d_%H%M%S)
                print_status "Existing .claude backed up"
            else
                print_warning "Skipping copy operation"
                print_success "Setup completed without copying files"
                print_status "You can manually copy later with:"
                print_status "  cp -r $SUBMODULE_NAME/.claude .claude"
                exit 0
            fi
        fi

        # Copy the .claude directory
        if cp -r "$SUBMODULE_NAME/.claude" .claude; then
            print_success "Files copied: $SUBMODULE_NAME/.claude -> .claude"
            print_status "Note: This is an independent copy. Updates to template won't auto-sync."
        else
            print_error "Failed to copy .claude directory"
            exit 1
        fi
        ;;
    *)
        print_error "Invalid choice. Please run the script again and choose 1 or 2."
        exit 1
        ;;
esac

# Step 4: Show completion message and next steps
print_success "Claude configuration setup completed successfully!"
echo ""
print_status "What was done:"
echo "  ✓ Added $TEMPLATE_REPO as submodule '$SUBMODULE_NAME'"
echo "  ✓ Configured sparse-checkout to only include .claude directory"
echo "  ✓ Created symbolic link .claude -> $SUBMODULE_NAME/.claude"
echo ""
print_status "Next steps:"
echo "  1. Commit the changes:"
echo "     git add ."
echo "     git commit -m 'Add Claude configuration as submodule'"
echo ""
echo "  2. To update Claude configuration in the future:"
echo "     git submodule update --remote $SUBMODULE_NAME"
echo ""
echo "  3. Your .claude configuration is now ready to use!"
echo ""
print_status "Alternative one-time setup (if you prefer not to use submodules):"
echo "  git subtree add --prefix=.claude $TEMPLATE_REPO main --squash"