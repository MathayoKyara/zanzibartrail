#!/bin/bash
set -e

# Install Flutter if not already available
if ! command -v flutter &> /dev/null; then
  echo "Flutter not found. Installing Flutter..."
  
  # Download and extract Flutter
  FLUTTER_VERSION="3.24.0"
  FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
  
  curl -L "$FLUTTER_URL" | tar xJ
  export PATH="$PATH:`pwd`/flutter/bin"
  
  # Accept licenses
  flutter doctor --android-licenses || true
  
  # Precache web dependencies
  flutter precache --web
else
  echo "Flutter found. Using existing installation."
  export PATH="$PATH:`pwd`/flutter/bin"
fi

# Verify Flutter installation
flutter --version

# Get dependencies
echo "Getting Flutter dependencies..."
flutter pub get

# Build for web
echo "Building Flutter web app..."
flutter build web --release

echo "Build completed successfully!"

