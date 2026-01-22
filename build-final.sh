#!/bin/bash
set -e

echo "Starting final Flutter build..."

# Environment setup
export PATH="/usr/local/bin:/usr/bin:/bin"
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_SYSTEM=/dev/null
export HOME=/tmp

# Make flutter wrapper executable
chmod +x flutter-wrapper.sh

# Create alias for flutter that uses our wrapper
flutter() {
    ./flutter-wrapper.sh "$@"
}

# Setup Flutter
echo "Setting up Flutter..."
./flutter-wrapper.sh config --enable-web

# Go to project
cd "$VERCEL_PROJECT_ROOT" || {
    echo "ERROR: Project directory not found"
    exit 1
}

echo "Project directory: $(pwd)"

# Get dependencies and build
echo "Getting dependencies..."
./flutter-wrapper.sh pub get

echo "Building..."
./flutter-wrapper.sh build web --release

echo "Build successful!"
ls build/web/
