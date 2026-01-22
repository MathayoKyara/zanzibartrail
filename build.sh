#!/bin/bash
set -e

echo "Starting Flutter build process..."

# Completely bypass any existing Flutter installations
export PATH="/usr/local/bin:/usr/bin:/bin"
unset FLUTTER_HOME
unset FLUTTER_ROOT

# Set environment to avoid all Git issues
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_SYSTEM=/dev/null
export HOME=/tmp

# Install Flutter in a clean location
echo "Installing fresh Flutter..."
cd /tmp
rm -rf flutter 2>/dev/null || true

# Download and extract Flutter
FLUTTER_VERSION="3.24.0"
echo "Downloading Flutter ${FLUTTER_VERSION}..."
curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" | tar xJ

# Set up Flutter environment
export PATH="/tmp/flutter/bin:$PATH"
export FLUTTER_HOME="/tmp/flutter"

# Configure Flutter
flutter config --enable-web
flutter precache --web --no-android

# Return to project directory
cd "$VERCEL_PROJECT_ROOT" || {
  echo "ERROR: Could not find project directory"
  exit 1
}

echo "Current directory: $(pwd)"
echo "Flutter version:"
flutter --version

# Get dependencies
echo "Getting Flutter dependencies..."
flutter pub get

# Build for web
echo "Building Flutter web app..."
flutter build web --release --no-web-resources-cdn

# Verify build output
if [ ! -d "build/web" ]; then
  echo "ERROR: Build output directory not found"
  exit 1
fi

echo "Build completed successfully!"
echo "Build output:"
ls -la build/web/ | head -10

