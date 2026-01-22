#!/bin/bash
set -e

echo "Ultra-minimal Flutter build..."

# Reset everything
export PATH="/bin:/usr/bin"
unset GIT_CONFIG_GLOBAL GIT_CONFIG_SYSTEM FLUTTER_HOME FLUTTER_ROOT
export HOME=/tmp

# Download and extract directly
cd /tmp
rm -rf flutter_ultra 2>/dev/null || true
mkdir flutter_ultra
curl -sL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz" | tar xJ -C flutter_ultra --strip-components=1

# Go to project and build directly
cd "$VERCEL_PROJECT_ROOT" || exit 1

echo "Building with isolated Flutter..."
/tmp/flutter_ultra/bin/flutter config --enable-web 2>/dev/null || true
/tmp/flutter_ultra/bin/flutter pub get
/tmp/flutter_ultra/bin/flutter build web --release

echo "Ultra build completed!"
ls build/web/ 2>/dev/null || echo "Build directory not found"
