# Charts Publisher

A GitHub Actions-powered solution for automatically publishing and maintaining your own Helm chart repository. This project makes it easy to set up a fully automated Helm chart repository with GitHub Pages hosting.

## Table of Contents

- [Features](#features)
- [Quick Start](#quick-start)
- [Setup Instructions](#setup-instructions)
- [Configuration](#configuration)
- [Usage](#usage)
- [Workflow Templates](#workflow-templates)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)

## Features

- **Automated Chart Updates**: Fetch and update charts from Git repositories or Helm repositories
- **Chart Customization**: Override chart metadata and values
- **GitHub Pages Integration**: Automatically publish charts to GitHub Pages
- **GitHub Actions Workflow**: Automated publishing with scheduled updates
- **Version Management**: Support for specific versions, tags, or commit hashes
- **Makefile Interface**: Simple command-line interface for all operations

## Quick Start

1. **Fork or copy this repository**
2. **Set up GitHub Pages** (see setup instructions below)
3. **Configure your charts** in the `sources/` directory
4. **Copy the workflow templates** to `.github/workflows/`
5. **Push to main branch** to trigger your first publish

## Setup Instructions

### 1. Repository Setup

1. **Fork this repository** or create a new repository and copy the files

2. **Enable GitHub Pages**:
   - Go to your repository Settings → Pages
   - Set Source to "GitHub Actions"
   - This will allow the workflows to deploy your charts

### 2. Copy Workflow Templates

The workflow files are provided as templates to avoid conflicts with your own CI. Copy them to your repository:

```bash
# Copy the workflow templates to your .github/workflows directory
cp -r templates/.github/workflows/* .github/workflows/
```

**Important**: The templates are located in `templates/.github/workflows/` and need to be copied to `.github/workflows/` in your repository.

### 3. Configure Your Repository

Edit the `Makefile` to set your repository details:

```makefile
# Update these values in the Makefile
GITHUB_USERNAME := YOUR_GITHUB_USERNAME
REPO_NAME := YOUR_REPO_NAME
REPO_URL := https://$(GITHUB_USERNAME).github.io/$(REPO_NAME)
```

Replace:
- `YOUR_GITHUB_USERNAME` with your actual GitHub username
- `YOUR_REPO_NAME` with your repository name

**Important**: The repository name should match your actual GitHub repository name.

### 4. Add Your Charts

Create chart configuration files in the `sources/` directory. See the examples in `sources/` for reference.

## Configuration

### Chart Source Configuration

Each chart is configured in a YAML file in the `sources/` directory. There are two types of sources:

#### Git Repository (for charts in Git repos)

```yaml
# sources/my-chart.yaml
repo_url: https://github.com/example/my-chart
chart_path: helm/
ref: main  # branch, tag, or commit hash

# Optional: Override chart metadata
chart_overrides:
  description: "My custom chart description"
  keywords:
    - my-app
    - kubernetes
  maintainers:
    - name: "Your Name"
      email: "your.email@example.com"

# Optional: Override default values
values_overrides:
  replicaCount: 2
  image:
    repository: myapp
    tag: "latest"
```

#### Helm Repository (for charts in Helm repos)

```yaml
# sources/nginx-ingress.yaml
repo_url: https://kubernetes.github.io/ingress-nginx
version: 4.7.1  # specific version to fetch

# Optional: Override chart metadata
chart_overrides:
  description: "NGINX Ingress Controller"
  keywords:
    - ingress
    - nginx
    - kubernetes
  maintainers:
    - name: "Your Name"
      email: "your.email@example.com"

# Optional: Override default values
values_overrides:
  controller:
    replicaCount: 2
```

### Configuration Options

#### For Git Repositories:
- **`repo_url`**: Git repository URL
- **`chart_path`**: Path to chart within the repository
- **`ref`**: Git reference (branch, tag, commit hash)

#### For Helm Repositories:
- **`repo_url`**: Helm repository URL
- **`version`**: Specific version to fetch

#### Common Options:
- **`chart_overrides`**: Custom chart metadata
- **`values_overrides`**: Custom default values

## Usage

### Automatic Publishing

The repository automatically publishes charts on:
- Push to main branch
- Weekly schedule (Sundays at 2 AM UTC)
- Manual trigger via GitHub Actions

### Manual Chart Updates

To update a specific chart:

1. Go to Actions → "Update Specific Chart"
2. Click "Run workflow"
3. Enter the chart name and optional version
4. Click "Run workflow"

### Adding New Charts

1. Create a new YAML file in `sources/` directory
2. Configure the chart source and options
3. Push to main branch or trigger manual update

## Workflow Templates

The project includes two workflow templates:

### `publish.yml`
- Publishes all charts automatically
- Runs on push to main, weekly schedule, and manual trigger
- Updates repository index and deploys to GitHub Pages

### `update-chart.yml`
- Updates a specific chart
- Manual trigger with chart name and optional version input
- Useful for testing or updating individual charts

### Copying Workflows

```bash
# From your repository root
mkdir -p .github/workflows
cp templates/.github/workflows/* .github/workflows/
```

## Examples

### Example 1: Helm Repository Chart

```yaml
# sources/nginx-ingress.yaml
repo_url: https://kubernetes.github.io/ingress-nginx
version: 4.7.1

chart_overrides:
  description: "NGINX Ingress Controller for Kubernetes"
  keywords:
    - ingress
    - nginx
    - kubernetes
```

### Example 2: Git Repository Chart

```yaml
# sources/my-app.yaml
repo_url: https://github.com/myorg/my-app
chart_path: charts/my-app
ref: v1.2.0

values_overrides:
  replicaCount: 3
  image:
    repository: myorg/my-app
    tag: "v1.2.0"
  resources:
    limits:
      memory: "512Mi"
      cpu: "500m"
```

### Example 3: Git Repository with Branch Reference

```yaml
# sources/ingress-nginx.yaml
repo_url: https://github.com/kubernetes/ingress-nginx
chart_path: charts/ingress-nginx
ref: helm-chart-4.31.1

chart_overrides:
  description: "NGINX Ingress Controller from Git Repository"
  keywords:
    - ingress
    - nginx
    - kubernetes
    - git-repo
```

## Troubleshooting

### Common Issues

1. **GitHub Pages not working**:
   - Ensure GitHub Pages is enabled in repository settings
   - Check that the workflow has proper permissions

2. **Charts not updating**:
   - Verify chart source configuration in `sources/` files
   - Check workflow logs for errors

3. **Permission errors**:
   - Ensure workflows have `contents: write` and `pages: write` permissions

### Debugging

- Check GitHub Actions logs for detailed error messages
- Use the manual "Update Specific Chart" workflow for testing
- Verify chart source URLs and references are correct

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with the CI workflow
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.