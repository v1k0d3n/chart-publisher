#!/bin/bash

# Charts Publisher Setup Script
# This script helps you set up the GitHub Actions workflows for your chart repository

set -e

echo "Charts Publisher Setup"
echo "=========================="

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "Error: This script must be run from a git repository root"
    exit 1
fi

# Check if templates directory exists
if [ ! -d "templates/.github/workflows" ]; then
    echo "Error: templates/.github/workflows directory not found"
    echo "Make sure you're running this script from the Charts Publisher repository root"
    exit 1
fi

# Create .github/workflows directory if it doesn't exist
echo "Creating .github/workflows directory..."
mkdir -p .github/workflows

# Copy workflow templates
echo "Copying workflow templates..."
cp templates/.github/workflows/* .github/workflows/

# Check if copy was successful
if [ $? -eq 0 ]; then
    echo "Successfully copied workflow templates to .github/workflows/"
    echo ""
    echo "Next steps:"
    echo "1. Update the Makefile with your repository details:"
    echo "   - Set REPO_NAME to your GitHub username"
    echo "   - Set REPO_URL to your repository's GitHub Pages URL"
    echo ""
    echo "2. Configure your charts in the sources/ directory"
    echo ""
    echo "3. Enable GitHub Pages in your repository settings:"
    echo "   - Go to Settings → Pages"
    echo "   - Set Source to 'GitHub Actions'"
    echo ""
    echo "4. Push to main branch to trigger your first publish"
    echo ""
    echo "Setup complete! Your Charts Publisher is ready to use."
else
    echo "Error: Failed to copy workflow templates"
    exit 1
fi
