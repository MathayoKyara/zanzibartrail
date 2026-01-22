#!/bin/bash
set -e

echo "Starting simple Flutter build..."

# Reset environment
export PATH="/usr/local/bin:/usr/bin:/bin"
unset FLUTTER_HOME
unset FLUTTER_ROOT
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_SYSTEM=/dev/null
export HOME=/tmp

# Use unique directory
cd /tmp
rm -rf flutter_simple 2>/dev/null || true
mkdir -p flutter_simple

# Download Flutter
echo "Downloading Flutter..."
curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz" | tar xJ -C flutter_simple --strip-components=1

# Set up environment
export PATH="/tmp/flutter_simple/bin:$PATH"
export FLUTTER_HOME="/tmp/flutter_simple"

# Configure
flutter config --enable-web

# Go to project
cd "$VERCEL_PROJECT_ROOT" || {
  echo "ERROR: Project directory not found"
  exit 1
}

echo "Project directory: $(pwd)"

# Get dependencies and build
flutter pub get
flutter build web --release

echo "Build successful!"
ls build/web/
