#!/bin/bash
set -e

echo "Starting final Flutter build..."

# Completely isolate environment
export PATH="/tmp/flutter_wrapper/bin:/usr/local/bin:/usr/bin:/bin"
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_SYSTEM=/dev/null
export HOME=/tmp
export FLUTTER_HOME="/tmp/flutter_wrapper"
export FLUTTER_ROOT="/tmp/flutter_wrapper"

# Remove any conflicting Flutter installations
rm -rf /tmp/flutter_wrapper /vercel/flutter 2>/dev/null || true

# Setup our Flutter
echo "Setting up isolated Flutter..."
mkdir -p /tmp/flutter_wrapper
cd /tmp
curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz" | tar xJ -C flutter_wrapper --strip-components=1

# Make sure our Flutter is used
chmod +x /tmp/flutter_wrapper/bin/flutter
export PATH="/tmp/flutter_wrapper/bin:$PATH"

# Verify we're using the right Flutter
echo "Flutter location: $(which flutter)"
echo "Flutter version: $(/tmp/flutter_wrapper/bin/flutter --version)"

# Go to project
cd "$VERCEL_PROJECT_ROOT" || {
    echo "ERROR: Project directory not found"
    exit 1
}

echo "Project directory: $(pwd)"

# Get dependencies and build using absolute paths
echo "Getting dependencies..."
/tmp/flutter_wrapper/bin/flutter pub get

echo "Building..."
/tmp/flutter_wrapper/bin/flutter build web --release

echo "Build successful!"
ls build/web/
