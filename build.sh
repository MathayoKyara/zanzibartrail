#!/bin/bash
set -e

echo "Starting Flutter build process..."

# Use a completely different directory name to avoid Vercel conflicts
export PATH="/usr/local/bin:/usr/bin:/bin"
unset FLUTTER_HOME
unset FLUTTER_ROOT
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_SYSTEM=/dev/null
export HOME=/tmp

# Install Flutter in a unique directory
echo "Installing Flutter to custom location..."
cd /tmp
rm -rf flutter_build 2>/dev/null || true
mkdir -p flutter_build

# Download and extract Flutter
FLUTTER_VERSION="3.24.0"
echo "Downloading Flutter ${FLUTTER_VERSION}..."
curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" | tar xJ -C flutter_build --strip-components=1

# Set up Flutter environment
export PATH="/tmp/flutter_build/bin:$PATH"
export FLUTTER_HOME="/tmp/flutter_build"

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

