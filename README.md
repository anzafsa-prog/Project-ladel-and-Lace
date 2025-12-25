# 🌸 Cherish - Women's Memory & Knowledge Management App

[![Flutter Version](https://img.shields.io/badge/Flutter-3.35.4-02569B?logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-blue)](https://flutter.dev)

> **The personal AI assistant that remembers everything you loved, so you can relive and share life's best moments effortlessly.**

Cherish is a viral "helping hand" mobile app designed for women (housewives + working women) to instantly capture and organize life memories and practical knowledge—recipes, places, trips, deals, favorite orders—then easily relive and share them with trusted circles.

---

## 🎯 **Problem & Solution**

**Target Audience:** Women aged 25-45 who need a fast "save it now, find it later" system for scattered information.

**Core Promise:** 5-second capture, powerful searchability, and optional sharing with trusted circles.

---

## ✨ **Key Features**

### 🎨 **1. Rose Gold Elegant Design**
- Beautiful, warm, uplifting aesthetic
- Soft gradients and modern typography
- Micro-animations for delightful interactions
- Card-based UI with memory timeline view
- Theme packs for personalization

### 📱 **2. Smart Vaults (6 Categories)**
- 🍳 **Recipes**: Ingredients, cooking time, servings, difficulty
- 📍 **Places**: Restaurants, cafes, shops with location pins
- ✈️ **Trips**: Travel memories, destinations, itineraries
- 👶 **Kids Spots**: Child-friendly locations and activities
- 💰 **Deals**: Special offers, discounts, promotions
- ⭐ **Favorites**: Must-try items, favorite orders

### 👥 **3. Circles (Social Layer)**
- WhatsApp-like groups for sharing memories
- Private, Family, Friends, Location-based circles
- Rich reactions: 😋 Yum, ⭐ Must-try, 👶 Kid-approved, 🔥 Fire, 💯 Love it, 📌 Saved
- Comments and collaborative lists
- "Save to My Vault" feature

### 💬 **4. WhatsApp Import (NEW!)**
- Screenshot-based memory capture
- Step-by-step instructions
- OCR text extraction (coming soon)
- Auto-detect category from content (coming soon)

### 🔍 **5. Discover & Search**
- City-based trending collections
- Search by intent and filters
- Circle Picks and recommendations
- Map view for place-based memories

### ➕ **6. One-Tap Capture**
- Photo capture (coming soon)
- Voice notes (coming soon)
- Text entry (coming soon)
- Link import (coming soon)
- WhatsApp screenshots (Phase 1 complete)

---

## 🏗️ **Technical Architecture**

### **Frontend**
- **Framework:** Flutter 3.35.4
- **Language:** Dart 3.9.2
- **UI:** Material Design 3
- **State Management:** Provider
- **Local Storage:** Hive (document DB) + shared_preferences (key-value)

### **Backend (Ready for Integration)**
- **Authentication:** Firebase Auth
- **Database:** Cloud Firestore
- **Storage:** Firebase Cloud Storage
- **Analytics:** Firebase Analytics

### **Platforms**
- ✅ Android (primary target)
- ✅ iOS (cross-platform ready)
- ✅ Web (preview & testing)

---

## 📂 **Project Structure**

```
flutter_app/
├── lib/
│   ├── config/
│   │   └── theme.dart              # Rose Gold theme configuration
│   ├── models/
│   │   ├── memory.dart             # Memory data model
│   │   ├── circle.dart             # Circle/group data model
│   │   ├── collection.dart         # Collection data model
│   │   └── user_profile.dart       # User profile model
│   ├── screens/
│   │   ├── home_screen.dart        # Home feed & quick actions
│   │   ├── vaults_screen.dart      # 6 categorized vaults
│   │   ├── add_screen.dart         # Capture methods selection
│   │   ├── discover_screen.dart    # Trending & discovery
│   │   ├── circles_screen.dart     # My Circles list
│   │   ├── circle_detail_screen.dart  # Circle memories feed
│   │   ├── create_circle_screen.dart  # Create new circle
│   │   ├── whatsapp_import_screen.dart # WhatsApp screenshot import
│   │   └── profile_screen.dart     # User profile & settings
│   ├── widgets/
│   │   ├── memory_card.dart        # Reusable memory card
│   │   └── circle_memory_card.dart # Circle memory card with reactions
│   └── main.dart                   # App entry point
├── assets/
│   └── icons/
│       └── app_icon.png            # Custom app icon
├── pubspec.yaml                    # Dependencies & assets
└── README.md                       # This file
```

---

## 🚀 **Getting Started**

### **Prerequisites**
- Flutter 3.35.4 or compatible version
- Dart 3.9.2 or compatible version
- Android Studio / VS Code with Flutter extensions
- Git

### **Installation**

1. **Clone the repository:**
```bash
git clone https://github.com/anzafsa-prog/Project-ladel-and-Lace.git
cd Project-ladel-and-Lace
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Run the app:**
```bash
# Web (for testing)
flutter run -d chrome

# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios
```

4. **Build for production:**
```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (macOS only)
flutter build ios --release

# Web
flutter build web --release
```

---

## 📦 **Dependencies**

### **Core Flutter Packages**
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # Firebase (ready for integration)
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  cloud_firestore: ^5.4.3
  firebase_storage: ^12.3.2
  
  # State Management
  provider: ^6.1.5+1
  
  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.5.3
  
  # Networking
  http: ^1.5.0
  
  # UI Components
  intl: ^0.19.0
  image_picker: ^1.0.7
  url_launcher: ^6.2.5
  uuid: ^4.3.3
  path_provider: ^2.1.2
```

---

## 🎨 **Design System**

### **Color Palette**
```dart
// Primary Colors
primaryRose: #E8B4B8      // Main brand color
secondaryRose: #C9A0A0    // Secondary accents
accentGold: #D4AF37       // Premium highlights

// Backgrounds
backgroundWarm: #FAF8F5   // Warm cream
surfaceWhite: #FFFFFF     // Pure white

// Status Colors
successGreen: #4CAF50     // Success states
errorRose: #F48FB1        // Error states
warningGold: #FFB74D      // Warning states

// Text Colors
textDark: #2C2C2C         // Primary text
textSecondary: #757575    // Secondary text
```

### **Typography**
- **Display:** Poppins (Bold, 600)
- **Headings:** Poppins (SemiBold, 600)
- **Body:** Inter (Regular, 400)

---

## 📊 **Current Development Status**

| Feature | Status | Completion |
|---------|--------|-----------|
| UI/Design System | ✅ Complete | 95% |
| Navigation & Routing | ✅ Complete | 100% |
| Core Screens (5) | ✅ Complete | 100% |
| Vaults System | ✅ Complete | 90% |
| Circles Feature | ✅ Complete | 90% |
| WhatsApp Import | 🔄 Phase 1 | 35% |
| Social Features | 🔄 In Progress | 60% |
| Firebase Integration | ⏳ Pending | 0% |
| Camera/Voice Capture | ⏳ Pending | 0% |
| Search & Filters | ⏳ Pending | 0% |
| Map View | ⏳ Pending | 0% |

**Legend:** ✅ Complete | 🔄 In Progress | ⏳ Pending

---

## 🗺️ **Roadmap**

### **Phase 1: MVP (Current)** ✅
- ✅ Rose Gold theme & UI system
- ✅ Core navigation (5 screens)
- ✅ Smart Vaults (6 categories)
- ✅ Circles feature (WhatsApp-like groups)
- ✅ WhatsApp Import (screenshot upload)
- ✅ Basic reactions & comments

### **Phase 2: Firebase Integration** 🔄
- ⏳ User authentication (email/password)
- ⏳ Cloud Firestore database
- ⏳ Firebase Cloud Storage
- ⏳ Real-time data sync
- ⏳ Security rules & permissions

### **Phase 3: Media Capture** ⏳
- ⏳ Camera integration
- ⏳ Voice recording
- ⏳ Photo gallery picker
- ⏳ Link import & preview
- ⏳ OCR text extraction (WhatsApp)

### **Phase 4: Smart Features** ⏳
- ⏳ AI categorization
- ⏳ Tag suggestions
- ⏳ Voice-to-text
- ⏳ Location detection
- ⏳ Search with filters

### **Phase 5: Discovery & Viral** ⏳
- ⏳ City trending collections
- ⏳ Map view for places
- ⏳ Advanced search
- ⏳ Shareable collection cards
- ⏳ Referral system

### **Phase 6: Premium Features** ⏳
- ⏳ Unlimited vaults
- ⏳ Advanced OCR
- ⏳ Extra themes & stickers
- ⏳ Family shared space
- ⏳ Yearly recap

---

## 🧪 **Testing**

### **Run Tests**
```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widget_test.dart

# Integration tests (when available)
flutter test integration_test/
```

### **Code Analysis**
```bash
# Static analysis
flutter analyze

# Code formatting
dart format .
```

---

## 🤝 **Contributing**

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 **Target Audience**

- **Primary:** Women aged 25-45 (housewives & working women)
- **Use Cases:**
  - Saving family recipes
  - Tracking favorite restaurants
  - Planning trips & destinations
  - Finding kid-friendly places
  - Discovering deals & offers
  - Sharing recommendations with friends

---

## 🎯 **Growth Strategy**

### **Viral Loops**
- Shareable collection cards (Instagram-story style)
- Invite friends for premium features
- Weekly challenge prompts
- City-based micro-communities

### **Monetization (Freemium)**
- **Free:** Core saving & sharing features
- **Premium:** Unlimited vaults, advanced search, OCR, themes, family space

---

## 📞 **Contact & Support**

- **Repository:** [github.com/anzafsa-prog/Project-ladel-and-Lace](https://github.com/anzafsa-prog/Project-ladel-and-Lace)
- **Issues:** [Report a bug or request a feature](https://github.com/anzafsa-prog/Project-ladel-and-Lace/issues)
- **Developer:** anzafsa-prog

---

## 🙏 **Acknowledgments**

- Flutter team for the amazing framework
- Material Design for UI guidelines
- Firebase for backend infrastructure
- All contributors and testers

---

## 📸 **Screenshots**

*Coming soon: App screenshots showcasing key features*

---

## 🔗 **Live Preview**

**Web Preview:** [https://5060-i5qvrv73ndi3fphg8dife-5185f4aa.sandbox.novita.ai](https://5060-i5qvrv73ndi3fphg8dife-5185f4aa.sandbox.novita.ai)

**Note:** This is a development preview. For the best experience, test on mobile devices.

---

Made with ❤️ for women who want to remember and share life's precious moments.

**#Cherish #MemoryApp #WomenInTech #FlutterApp #SocialMemories**
