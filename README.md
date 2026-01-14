# OpenCode Docker Image

A ready-to-use Docker image for running OpenCode with all necessary models and dependencies pre-downloaded.

## Overview

This Docker image is based on Ubuntu and comes with OpenCode pre-installed and initialized. All required models and files are downloaded during the image build process, allowing you to start using OpenCode immediately without any additional setup or waiting for downloads.

## Features

- **Ubuntu-based**: Built on Ubuntu 22.04 LTS for stability and compatibility
- **Pre-configured**: OpenCode is installed and initialized with all necessary models
- **Ready-to-use**: No additional setup required - just run the container
- **Auto-deployment**: Automatically built and pushed to Docker Hub on every Dockerfile update
- **Default workspace**: Automatically creates and uses `/contents` directory as the working directory

## Quick Start

### Pull and Run

```bash
# Pull the latest image from Docker Hub
docker pull winm2m/opencode:latest

# Run OpenCode interactively
docker run -it winm2m/opencode:latest

# Run with a mounted volume to persist your work
docker run -it -v $(pwd):/contents winm2m/opencode:latest

# Run with a specific file
docker run -it -v $(pwd):/contents winm2m/opencode:latest sh -c "opencode your-file.py"
```

### Usage Examples

#### Example 1: Interactive Mode

```bash
docker run -it winm2m/opencode:latest
```

This will start OpenCode in the `/contents` directory where you can interactively work with your code.

#### Example 2: Mount Local Directory

```bash
# Mount your current directory to work with local files
docker run -it -v $(pwd):/contents winm2m/opencode:latest
```

#### Example 3: Run with Custom Command

```bash
# Run a specific command instead of the default
docker run -it winm2m/opencode:latest sh -c "cd /contents && ls -la"
```

## Building Locally

If you want to build the image locally:

```bash
# Clone the repository
git clone https://github.com/YoungjuneKwon/dockerimage-winm2m-opencode.git
cd dockerimage-winm2m-opencode

# Build the Docker image
docker build -t opencode:local .

# Run the locally built image
docker run -it opencode:local
```

## How It Works

1. **Installation**: The Dockerfile installs OpenCode using the official installation script:
   ```bash
   curl -fsSL https://opencode.ai/install | bash
   ```

2. **Pre-download**: During the build process, OpenCode is initialized to download all necessary models and dependencies, ensuring they're ready when you run the container.

3. **Default Command**: When the container starts, it automatically:
   - Creates the `/contents` directory if it doesn't exist
   - Changes to the `/contents` directory
   - Launches OpenCode

## Automatic Deployment

This repository uses GitHub Actions to automatically build and push the Docker image to Docker Hub whenever the Dockerfile is modified. The workflow:

- Triggers on pushes to the main/master branch when Dockerfile changes
- Builds the Docker image using Docker Buildx
- Authenticates with Docker Hub using repository secrets
- Pushes the image to `winm2m/opencode:latest`
- Uses layer caching for faster builds

## Repository Structure

```
.
├── Dockerfile                          # Docker image definition
├── .github/
│   └── workflows/
│       └── docker-publish.yml         # GitHub Actions workflow for auto-deployment
└── README.md                          # This file
```

## Requirements

- Docker installed on your system
- (For building) GitHub repository secrets configured:
  - `DOCKERHUB_USERNAME`: Your Docker Hub username
  - `DOCKERHUB_TOKEN`: Your Docker Hub access token

## Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements.

## License

This project is open source and available for use as needed.

## Links

- Docker Hub: [winm2m/opencode](https://hub.docker.com/r/winm2m/opencode)
- GitHub Repository: [YoungjuneKwon/dockerimage-winm2m-opencode](https://github.com/YoungjuneKwon/dockerimage-winm2m-opencode)
- OpenCode Official: [https://opencode.ai](https://opencode.ai)
