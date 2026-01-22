#!/bin/bash
set -e

# Flutter wrapper that always uses our local installation
FLUTTER_DIR="/tmp/flutter_wrapper"

# Setup Flutter if not exists
if [ ! -d "$FLUTTER_DIR/bin" ]; then
    echo "Setting up Flutter wrapper..."
    mkdir -p "$FLUTTER_DIR"
    cd /tmp
    rm -rf flutter_wrapper 2>/dev/null || true
    curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz" | tar xJ -C flutter_wrapper --strip-components=1
fi

# Always use our Flutter
export PATH="$FLUTTER_DIR/bin:$PATH"
export FLUTTER_HOME="$FLUTTER_DIR"
export FLUTTER_ROOT="$FLUTTER_DIR"

# Execute Flutter with all arguments
exec "$FLUTTER_DIR/bin/flutter" "$@"
