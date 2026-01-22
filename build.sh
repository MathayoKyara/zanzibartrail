#!/bin/bash
set -e

echo "Starting Flutter build process..."

# Completely override environment to force our Flutter
export PATH="/tmp/flutter_build/bin:/usr/local/bin:/usr/bin:/bin"
export FLUTTER_HOME="/tmp/flutter_build"
export FLUTTER_ROOT="/tmp/flutter_build"
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_SYSTEM=/dev/null
export HOME=/tmp

# Remove any existing Flutter and create new one
echo "Setting up Flutter in isolated environment..."
cd /tmp
rm -rf flutter_build /vercel/flutter 2>/dev/null || true
mkdir -p flutter_build

# Download and extract Flutter directly
FLUTTER_VERSION="3.24.0"
echo "Downloading Flutter ${FLUTTER_VERSION}..."
curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" | tar xJ -C flutter_build --strip-components=1

# Verify our Flutter is being used
export PATH="/tmp/flutter_build/bin:$PATH"
echo "Flutter location: $(which flutter)"
echo "Flutter version: $(flutter --version)"

# Configure Flutter
flutter config --enable-web
flutter precache --web --no-android

# Return to project directory
cd "$VERCEL_PROJECT_ROOT" || {
  echo "ERROR: Could not find project directory"
  echo "Current directory: $(pwd)"
  exit 1
}

echo "Current directory: $(pwd)"

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

