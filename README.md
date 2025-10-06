# FoodTrans 🍔

A modern, feature-rich food delivery application built with Flutter and Firebase. FoodTrans enables users to browse restaurants, order food, track deliveries in real-time, and manage their profiles seamlessly.

## 📱 Overview

FoodTrans is a comprehensive food ordering platform that connects customers with their favorite restaurants. The application provides an intuitive interface for browsing menus, placing orders, real-time order tracking, and in-app communication with delivery personnel.

## ✨ Features

### User Authentication
- Secure Firebase Authentication integration
- Email/password authentication
- Custom authentication repository with state management
- Persistent login sessions

### Food Browsing & Ordering
- Browse food items by categories (Burgers, Tacos, Drinks, Pizza, etc.)
- Detailed food item views with descriptions and pricing
- Rating and review system
- Distance calculation to restaurants
- Add to cart functionality with quantity adjustment
- Real-time price calculations

### Location Services
- Real-time location tracking using Geolocator
- Distance-based restaurant filtering
- Location permission handling
- Proximity-based restaurant recommendations

### Order Management
- Real-time order tracking
- Order status updates (Preparing, In Delivery, Delivered)
- Order history with detailed information
- Order ID tracking system

### Chat & Communication
- In-app messaging system
- Order-specific chat rooms
- Real-time message notifications
- Delivery status updates

### User Profile
- Complete profile management
- Profile picture upload and management
- Personal information editing (Name, Date of Birth, Gender, Phone, Email)
- Order history viewing
- Settings customization

### Settings & Preferences
- Push notification controls
- Location services toggle
- Multi-language support
- Account management (Sign out, Delete account)
- Privacy policy and terms & conditions

### Additional Features
- Cached network images for optimal performance
- Offline support with SharedPreferences
- Image picker for profile pictures
- Custom form validation
- Internationalization support

## 🛠️ Tech Stack

### Framework & Language
- **Flutter SDK**: >=3.7.0 <4.0.0
- **Dart**: Latest stable version

### State Management
- **flutter_bloc** (^9.1.0): State management using BLoC pattern
- **bloc** (^9.0.0): Core BLoC library
- **equatable** (^2.0.0): Value equality

### Backend & Database
- **firebase_core** (^3.15.2): Firebase initialization
- **firebase_messaging** (^15.2.10): Push notifications
- **Authentication Repository**: Custom package for auth management

### Location Services
- **geolocator** (^9.0.2): Location tracking and distance calculation
- **permission_handler** (^11.0.1): Runtime permissions management

### UI/UX
- **google_fonts** (^6.0.0): Custom typography
- **font_awesome_flutter** (^10.1.0): Icon library
- **cupertino_icons** (^1.0.8): iOS-style icons
- **cached_network_image** (^3.3.0): Image caching and loading

### Form Handling
- **formz** (^0.8.0): Form validation
- **form_inputs**: Custom package for reusable form inputs

### Media
- **image_picker** (^1.0.4): Camera and gallery access

### Localization
- **intl** (^0.19.0): Internationalization
- **flutter_localizations**: Flutter localization support

### Data Persistence
- **shared_preferences** (^2.2.2): Local data storage

### Development Dependencies
- **flutter_test**: Testing framework
- **flutter_lints** (^5.0.0): Linting rules
- **bloc_test** (^10.0.0): BLoC testing utilities
- **mocktail** (^1.0.0): Mocking library
- **bloc_lint** (^0.2.0-dev.0): BLoC-specific linting

## 📁 Project Structure

```
lib/
├── app/                    # App-level configuration
├── cart/                   # Shopping cart feature
├── chat/                   # Messaging system
├── checkout/               # Order checkout process
├── food_details/           # Food item details view
├── home/                   # Home screen
├── login/                  # Login functionality
├── navigation/             # App navigation logic
├── notifications/          # Push notification handling
├── product/                # Product management
├── profile/                # User profile management
├── repositories/           # Data repositories
├── settings/               # App settings
├── shared/                 # Shared utilities and widgets
├── sign_up/                # Registration functionality
├── splash/                 # Splash screen
│   └── view/
├── util/                   # Utility functions
├── widgets/                # Reusable widgets
├── firebase_options.dart   # Firebase configuration
└── main.dart              # App entry point

packages/
├── authentication_repository/  # Authentication logic
└── form_inputs/                # Form validation inputs
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.7.0)
- Dart SDK (>=3.7.0)
- Firebase account
- Android Studio / Xcode for mobile development
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/Brightnyandiko/FoodTrans.git
cd FoodTrans
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Firebase Setup**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android/iOS apps to your Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place configuration files in appropriate directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`
   - Enable Firebase Authentication and Cloud Messaging in Firebase Console

4. **Configure Firebase**
```bash
flutter pub run firebase_core:configure
```

5. **Generate localizations**
```bash
flutter gen-l10n
```

6. **Run the app**
```bash
flutter run
```

## 🔧 Configuration

### Environment Setup

1. **Android Configuration**
   - Minimum SDK: Check `android/app/build.gradle`
   - Add internet permission in `AndroidManifest.xml`
   - Configure Google Services plugin

2. **iOS Configuration**
   - Update `Info.plist` with location and camera permissions
   - Configure Firebase in Xcode
   - Set minimum deployment target

3. **Assets**
   - Place your assets in the `assets/` directory
   - Update `pubspec.yaml` if adding new asset directories

### Firebase Services Required
- Authentication (Email/Password)
- Cloud Messaging (Push Notifications)
- Firestore (Optional - for data storage)
- Storage (Optional - for image uploads)

## 🧪 Testing

Run tests using:
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

## 📱 Building for Production

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🎨 Code Style

This project follows the official Flutter style guide and uses:
- `flutter_lints` for code analysis
- `bloc_lint` for BLoC-specific linting
- Consistent naming conventions throughout

Run linting:
```bash
flutter analyze
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is private. All rights reserved.

## 👤 Author

**Bright Nyandiko**
- GitHub: [@Brightnyandiko](https://github.com/Brightnyandiko)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All open-source package contributors

## 📞 Support

For support, please open an issue in the GitHub repository or contact the development team.

---

**Version**: 1.0.0+1

**Last Updated**: October 2025
