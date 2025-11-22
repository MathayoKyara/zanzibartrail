#!/bin/bash
set -e

# Set Flutter home to avoid root user issues
export FLUTTER_HOME="${FLUTTER_HOME:-$HOME/flutter}"
export PATH="$FLUTTER_HOME/bin:$PATH"

# Fix Git ownership issues
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_SYSTEM=/dev/null

# Install Flutter if not already available
if ! command -v flutter &> /dev/null; then
  echo "Flutter not found. Installing Flutter..."
  
  # Create Flutter directory
  mkdir -p "$FLUTTER_HOME"
  cd "$FLUTTER_HOME/.."
  
  # Download and extract Flutter
  # Using a recent stable version - update this if needed
  FLUTTER_VERSION="3.24.0"
  FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
  
  echo "Downloading Flutter ${FLUTTER_VERSION}..."
  curl -L "$FLUTTER_URL" | tar xJ
  
  # Move to proper location if needed
  if [ -d "flutter" ]; then
    mv flutter "$FLUTTER_HOME" || true
  fi
  
  export PATH="$FLUTTER_HOME/bin:$PATH"
  
  # Fix Git ownership in Flutter directory
  if [ -d "$FLUTTER_HOME/.git" ]; then
    echo "Fixing Git ownership in Flutter directory..."
    cd "$FLUTTER_HOME"
    git config --global --add safe.directory "$FLUTTER_HOME" || true
    git config --local --unset-all core.fileMode || true
    git config --local core.fileMode false || true
    cd - > /dev/null
  fi
  
  # Accept licenses (skip Android licenses for web-only build)
  flutter doctor --android-licenses || echo "Skipping Android licenses (web-only build)"
  
  # Precache web dependencies only
  flutter precache --web || echo "Precache warning (continuing anyway)"
else
  echo "Flutter found. Using existing installation."
  
  # Fix Git ownership if Flutter is already installed
  if [ -d "$FLUTTER_HOME/.git" ]; then
    echo "Fixing Git ownership in existing Flutter installation..."
    cd "$FLUTTER_HOME"
    git config --global --add safe.directory "$FLUTTER_HOME" || true
    git config --local core.fileMode false || true
    cd - > /dev/null
  fi
fi

# Return to project directory
cd "$VERCEL_PROJECT_ROOT" || cd "$(dirname "$0")/.." || pwd

# Fix Git ownership for project directory if needed
if [ -d ".git" ]; then
  echo "Fixing Git ownership for project directory..."
  git config --global --add safe.directory "$(pwd)" || true
  git config --local core.fileMode false || true
fi

# Verify Flutter installation
echo "Verifying Flutter installation..."
flutter --version || {
  echo "ERROR: Flutter installation failed"
  exit 1
}

# Get dependencies
echo "Getting Flutter dependencies..."
flutter pub get || {
  echo "ERROR: Failed to get dependencies"
  exit 1
}

# Build for web
echo "Building Flutter web app..."
flutter build web --release || {
  echo "ERROR: Build failed"
  exit 1
}

# Verify build output
if [ ! -d "build/web" ]; then
  echo "ERROR: Build output directory not found"
  exit 1
fi

echo "Build completed successfully!"
ls -la build/web/ | head -20

