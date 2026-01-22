#!/bin/bash
set -e

# Set environment variables to avoid Git ownership issues
export GIT_CONFIG_GLOBAL=/tmp/gitconfig
export GIT_CONFIG_SYSTEM=/tmp/gitconfig
export HOME=/tmp

# Create a temporary git config to avoid ownership issues
touch $GIT_CONFIG_GLOBAL
touch $GIT_CONFIG_SYSTEM

# Install Flutter if not available
if ! command -v flutter &> /dev/null; then
  echo "Installing Flutter..."
  
  # Download Flutter to temporary directory
  mkdir -p /tmp/flutter
  cd /tmp
  
  # Use a stable Flutter version
  FLUTTER_VERSION="3.24.0"
  FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
  
  echo "Downloading Flutter ${FLUTTER_VERSION}..."
  curl -L "$FLUTTER_URL" | tar xJ
  
  # Add Flutter to PATH
  export PATH="/tmp/flutter/bin:$PATH"
  
  # Configure Flutter for web
  flutter config --enable-web
  flutter precache --web
else
  echo "Flutter found, using existing installation"
  flutter config --enable-web
fi

# Return to project directory
cd "$VERCEL_PROJECT_ROOT" || pwd

# Verify Flutter installation
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

