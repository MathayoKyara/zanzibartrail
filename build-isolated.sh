#!/bin/bash
set -e

echo "Isolated Flutter build - Complete bypass..."

# Create completely isolated environment
export PATH=""
export HOME="/tmp/isolated"
mkdir -p "$HOME"

# Download and setup Flutter in isolated environment
cd /tmp
rm -rf flutter_isolated 2>/dev/null || true
mkdir flutter_isolated
curl -sL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz" | tar xJ -C flutter_isolated --strip-components=1

# Set minimal PATH with only our Flutter
export PATH="/tmp/flutter_isolated/bin"

# Go to project and build
cd "$VERCEL_PROJECT_ROOT" || {
    echo "ERROR: Project directory not found"
    exit 1
}

echo "Building with completely isolated Flutter..."
flutter config --no-analytics --enable-web
flutter pub get
flutter build web --release

echo "Isolated build completed!"
if [ -d "build/web" ]; then
    echo "✅ SUCCESS: Build completed!"
    ls build/web/ | head -3
else
    echo "❌ FAILED: Build directory not found"
    exit 1
fi
