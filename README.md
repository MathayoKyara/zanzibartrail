# Zanzibar Trail Tours - Flutter App

A beautiful, modern Flutter application for Zanzibar Trail Tours showcasing tours, safaris, and travel information for Tanzania.

## Features

### 🏝️ Zanzibar Tours & Excursions
- **Stone Town Walking Tour**: 20 – 40 USD pp
- **Spice Farm Tour**: 15 – 50 USD pp (Private ~100 USD/2pax)
- **Prison Island (Changuu)**: 25 – 40 USD pp
- **Jozani Forest Tour**: 25 – 45 USD pp
- **Nakupenda Sandbank**: 40 – 65 USD pp
- **Safari Blue (Full Day)**: 65 USD pp (group), Private ~450 USD (up to 6pax)
- **Mnemba Atoll Snorkeling**: 40 – 60 USD pp
- **Dolphin Tour (Kizimkazi)**: 30 – 50 USD pp
- **Sunset Dhow Cruise**: 30 – 50 USD pp
- **Deep Sea Fishing**: 450 – 600 USD / boat (shared costs)
- **Kite Surfing (lessons)**: 50 – 100 USD pp
- **Scuba Diving (2 dives)**: 120 – 150 USD pp

### 🦁 Tanzania Mainland Safaris
- **Ngorongoro Crater (Day Trip from Zanzibar)**: 790 – 1,276 USD pp
- **Ngorongoro (Per Day estimate)**: 500 – 1,360 USD pp
- **Serengeti (3-Day Mid-Range)**: 450 – 1,700 USD pp
- **Serengeti (Per Day)**: 200 USD (budget) – 600+ USD (luxury)
- **2-Day Safari (from Zanzibar)**: 818+ USD pp
- **3–5 Day Safari (Serengeti + Ngorongoro)**: 1,500 – 3,500 USD pp
- **Luxury Safaris**: Up to 5,000+ USD pp

### 🗺️ Travel Guide
Comprehensive travel information including:
- How to get to each tour location
- Travel times and transport options
- Detailed travel tips and recommendations

## Design Features

- **Modern UI**: Clean, beautiful design with gradient backgrounds and card-based layouts
- **Responsive Design**: Works across different screen sizes
- **Color-coded Tours**: Each tour type has its own color scheme for easy identification
- **Interactive Elements**: Smooth animations and intuitive navigation
- **Price Display**: Clear pricing information with color-coded badges
- **Travel Information**: Detailed travel guides with icons and structured information

## Technical Stack

- **Framework**: Flutter
- **Language**: Dart
- **UI Components**: Material Design
- **Additional Packages**: 
  - google_fonts: For beautiful typography
  - cached_network_image: For optimized image loading
  - url_launcher: For external links
  - intl: For internationalization

## Project Structure

```
frontend/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── tours_screen.dart
│   │   ├── booking_screen.dart
│   │   ├── contact_screen.dart
│   │   ├── about_screen.dart
│   │   ├── gallery_screen.dart
│   │   └── testimonials_screen.dart
│   └── widgets/
│       └── bottom_navigation.dart
├── assets/
│   ├── images/
│   └── icons/
└── pubspec.yaml
```

## Getting Started

### Local Development

1. Ensure you have Flutter installed
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run -d chrome` to start the application in Chrome

### GitHub Pages Deployment

This project is configured for automatic deployment to GitHub Pages. The website will be available at:
**https://mathayokyara.github.io/zttwebsite/**

#### Setup Instructions:

1. **Enable GitHub Pages in your repository:**
   - Go to your repository settings on GitHub
   - Navigate to "Pages" in the left sidebar
   - Under "Source", select "GitHub Actions"
   - Save the changes

2. **Automatic Deployment:**
   - The GitHub Actions workflow (`.github/workflows/deploy.yml`) will automatically build and deploy your Flutter web app whenever you push to the `main` branch
   - The workflow builds the Flutter web app with the correct base href (`/zttwebsite/`) for GitHub Pages
   - Deployment typically takes 2-5 minutes

3. **Manual Deployment (if needed):**
   ```bash
   flutter build web --base-href "/zttwebsite/" --release
   ```
   Then manually upload the `build/web` folder contents to the `gh-pages` branch

#### Important Notes:

- The base href is set to `/zttwebsite/` to match your repository name
- The `.nojekyll` file ensures GitHub Pages doesn't process files with Jekyll
- All assets and routes are configured to work correctly with the GitHub Pages subdirectory structure

## Screenshots

The app features:
- **Hero Section**: Beautiful gradient background with call-to-action buttons
- **Featured Tours**: Highlighted tours with pricing and descriptions
- **Pricing Section**: Comprehensive price lists for all tours and safaris
- **Why Choose Us**: Feature highlights with icons and descriptions
- **Testimonials**: Customer reviews and ratings
- **Contact Section**: Call-to-action for bookings and inquiries

## Color Scheme

- **Primary**: Ocean Teal (#00695C)
- **Secondary**: Sunset Orange (#FF9800)
- **Accent Colors**: Various colors for different tour categories
- **Background**: Clean whites and subtle grays
- **Text**: Dark grays for readability

## Future Enhancements

- Image gallery for each tour
- Booking calendar integration
- Payment processing
- Multi-language support
- Push notifications
- Offline mode
- User reviews and ratings system
