#!/bin/bash
set -e

echo "Minimal Flutter build..."

# Reset everything
export PATH="/bin:/usr/bin"
unset GIT_CONFIG_GLOBAL GIT_CONFIG_SYSTEM FLUTTER_HOME FLUTTER_ROOT
export HOME=/tmp

# Download and use Flutter
cd /tmp
rm -rf flutter 2>/dev/null || true
curl -sL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz" | tar xJ
export PATH="/tmp/flutter/bin:$PATH"

cd "$VERCEL_PROJECT_ROOT" || exit 1
flutter config --enable-web 2>/dev/null || true
flutter pub get
flutter build web --release

echo "Build done!"
