# Vercel Deployment Guide

This guide will help you deploy your Flutter web app to Vercel.

## Prerequisites

- A Vercel account (sign up at [vercel.com](https://vercel.com))
- Flutter SDK installed on your local machine (for building)
- Git repository with your code

## Deployment Steps

### Option 1: Deploy via Vercel Dashboard (Recommended)

1. **Connect your repository:**
   - Go to [vercel.com/new](https://vercel.com/new)
   - Import your Git repository
   - Vercel will automatically detect the Flutter project

2. **Configure build settings:**
   - **Framework Preset:** Other
   - **Build Command:** `bash build.sh` (uses the provided build script)
   - **Output Directory:** `build/web`
   - **Install Command:** Leave empty (handled in build script)

3. **Deploy:**
   - Click "Deploy"
   - Vercel will build and deploy your app automatically

### Option 2: Pre-build Locally and Deploy Static Files

If you encounter build issues on Vercel, you can build locally and deploy the static files:

1. **Build locally:**
   ```bash
   flutter pub get
   flutter build web --release
   ```

2. **Deploy to Vercel:**
   - Use Vercel CLI: `vercel --prod`
   - Or drag and drop the `build/web` folder to Vercel dashboard

3. **Deploy:**
   - Click "Deploy"
   - Vercel will build and deploy your app automatically

### Option 2: Deploy via Vercel CLI

1. **Install Vercel CLI:**
   ```bash
   npm i -g vercel
   ```

2. **Login to Vercel:**
   ```bash
   vercel login
   ```

3. **Deploy:**
   ```bash
   vercel
   ```

4. **For production deployment:**
   ```bash
   vercel --prod
   ```

## Configuration Files

The project includes the following Vercel configuration:

- **`vercel.json`**: Contains routing rules and headers configuration
  - All routes are rewritten to `index.html` for client-side routing
  - Cache headers are set for optimal performance
  - Security headers are configured

- **`.vercelignore`**: Excludes unnecessary files from deployment

## Build Configuration

The app is configured to build with:
- Base href: `/` (root path)
- Release mode for optimized production build

## Important Notes

1. **Routing:** Vercel handles client-side routing automatically through the `vercel.json` configuration. All routes will be served through `index.html`.

2. **Build Output:** The build output is in `build/web` directory, which is configured in `vercel.json`.

3. **Environment Variables:** If you need environment variables, add them in the Vercel dashboard under Project Settings > Environment Variables.

4. **Custom Domain:** You can add a custom domain in the Vercel dashboard under Project Settings > Domains.

## Troubleshooting

### 404 Errors on Refresh

If you're getting 404 errors when refreshing pages:
- Ensure `vercel.json` is in the root directory
- Check that the `rewrites` configuration is correct
- Verify the build output directory is `build/web`

### Build Failures

If the build fails:
- **Flutter not found:** The `build.sh` script should automatically install Flutter. If it fails, try building locally and deploying the `build/web` folder instead.
- **Dependencies:** Check that all dependencies are listed in `pubspec.yaml`
- **Build logs:** Review build logs in Vercel dashboard for specific errors
- **Alternative:** Build locally with `flutter build web --release` and deploy the `build/web` folder directly

### Assets Not Loading

If assets are not loading:
- Verify the `base href` in `web/index.html` is set to `/`
- Check that assets are included in `pubspec.yaml`
- Ensure asset paths are relative (not absolute)

## Differences from GitHub Pages

- **Base href:** Changed from `/zttwebsite/` to `/` for root domain deployment
- **Routing:** Uses Vercel's rewrite rules instead of GitHub Pages 404.html workaround
- **Build command:** No need for `--base-href` flag (uses default `/`)

## Support

For more information, visit:
- [Vercel Documentation](https://vercel.com/docs)
- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)

