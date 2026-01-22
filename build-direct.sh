#!/bin/bash
set -e

echo "Direct Flutter build..."

# Clean environment
export PATH="/bin:/usr/bin"
export HOME=/tmp

# Setup Flutter
cd /tmp
rm -rf flutter_direct 2>/dev/null || true
mkdir flutter_direct
curl -sL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz" | tar xJ -C flutter_direct --strip-components=1

# Build directly
cd "$VERCEL_PROJECT_ROOT" || exit 1

echo "Building web app..."
/tmp/flutter_direct/bin/flutter config --no-analytics --enable-web
/tmp/flutter_direct/bin/flutter pub get
/tmp/flutter_direct/bin/flutter build web --release --no-web-resources-cdn

echo "Build completed!"
if [ -d "build/web" ]; then
    echo "✅ Build successful!"
    ls build/web/ | head -5
else
    echo "❌ Build failed - no build/web directory"
    exit 1
fi
