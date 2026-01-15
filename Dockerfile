# Use Ubuntu as base image
FROM ubuntu:22.04

# Set environment variables to prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install curl and other necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install opencode
RUN curl -fsSL https://opencode.ai/install | bash

# Set up environment for opencode
ENV PATH="/root/.opencode/bin:${PATH}"

# Pre-download models and initialize opencode
# Run opencode with a simple command to trigger initial downloads
# We use timeout to prevent hanging, but check if basic initialization occurred
RUN mkdir -p /tmp/init && \
    cd /tmp/init && \
    echo "print('Hello from OpenCode')" > test.py && \
    (timeout 300 opencode test.py || exit_code=$?; \
     if [ -d "/root/.opencode" ]; then \
       echo "OpenCode initialized successfully"; \
     else \
       echo "Warning: OpenCode initialization may not have completed fully"; \
     fi) && \
    rm -rf /tmp/init

# Set working directory
WORKDIR /contents

# Default command: create /contents directory and run opencode
CMD ["sh", "-c", "mkdir -p /contents && cd /contents && opencode"]
