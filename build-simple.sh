#!/bin/bash
set -e

echo "Starting Flutter build process..."

# Set up environment
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin"
export HOME=/tmp

# Try to use system Flutter first
if command -v flutter &> /dev/null; then
    echo "Using system Flutter"
    flutter config --enable-web
else
    echo "Flutter not found, attempting to install..."
    
    # Install Flutter to /tmp
    cd /tmp
    curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz" | tar xJ
    export PATH="/tmp/flutter/bin:$PATH"
    flutter config --enable-web
fi

# Return to project directory
cd "$VERCEL_PROJECT_ROOT" || pwd

echo "Current directory: $(pwd)"
echo "Flutter version:"
flutter --version

echo "Getting dependencies..."
flutter pub get

echo "Building for web..."
flutter build web --release

echo "Build completed!"
ls -la build/web/
