#!/bin/bash

# Quick deployment script for Vercel
# Usage: ./deploy-to-vercel.sh

set -e

echo "🚀 Zanzibar Trail Tours - Vercel Deployment"
echo "============================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Error: Flutter is not installed or not in PATH"
    echo "Please install Flutter first: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel@latest
fi

echo "📦 Getting Flutter dependencies..."
flutter pub get

echo "🔨 Building Flutter web app..."
flutter build web --release

if [ ! -d "build/web" ]; then
    echo "❌ Error: Build output not found"
    exit 1
fi

echo "✅ Build completed successfully!"
echo ""
echo "📤 Deploying to Vercel..."
echo ""

cd build/web
vercel --prod

echo ""
echo "✅ Deployment complete!"
echo "🌐 Your site should be live now!"

