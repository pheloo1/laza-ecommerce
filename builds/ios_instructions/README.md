# Laza E-commerce Mobile App

A functional e-commerce mobile application built with **Flutter** for Android and iOS, using **Firebase** for authentication and data storage. This project was developed as part of an academic Mobile App Development requirement.

---

## Project Overview

**Project Name:** Laza – E-commerce Mobile App  
**Framework:** Flutter (single codebase)  
**Platforms:** Android & iOS  
**Backend:** Firebase  
**Testing:** Appium (End-to-End)

The goal of this project is to demonstrate a complete mobile e-commerce flow including authentication, product browsing, cart management, favorites, and checkout.

---

## Features

- User authentication (Firebase Email/Password)
- Product listing and product details
- Add and remove items from cart
- Favorites (wishlist) functionality
- Checkout flow (mock checkout)
- Persistent user data with Firestore
- End-to-End testing using Appium
- Demo video walkthrough

---

## Tech Stack

- **Flutter**
- **Dart**
- **Firebase Authentication**
- **Cloud Firestore**
- **Provider** (state management)
- **Platzi Fake Store API** (product data)
- **Appium** (E2E testing)

---

## Prerequisites

Make sure the following are installed:

- Flutter SDK
- Dart SDK
- Android Studio (with emulator) or Xcode (for iOS)
- Node.js & npm (for Appium)
- Firebase CLI

Verify Flutter installation:

```bash
flutter doctor
```

---

## Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd laza-ecommerce
```

### 2. Install Dependencies

```bash
flutter pub get
```

---

## Firebase Setup

Firebase is used for authentication and Firestore database.

### Configuration Files

- **Android:** `android/app/google-services.json`
- **iOS:** `ios/Runner/GoogleService-Info.plist`

### Firebase Console Steps

1. Create a Firebase project
2. Enable **Email/Password Authentication**
3. Create a **Cloud Firestore** database
4. Add Android and iOS apps to the Firebase project

### Firestore Rules

Firestore rules are provided in:

```
firestore.rules
```

(Optional) Deploy rules:

```bash
firebase deploy --only firestore:rules
```

---

## Running the App

### Android

```bash
flutter run
```

### iOS (macOS only)

```bash
cd ios
pod install
cd ..
flutter run
```

---

## Project Structure

```
laza-ecommerce/
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── services/
│   ├── screens/
│   └── widgets/
├── android/
├── ios/
├── assets/
├── appium_tests/
├── docs/
│   ├── screenshots/
│   └── results/
├── builds/
│   └── apk/
├── video/
│   └── demo.mp4
├── firebase.json
├── firestore.rules
└── README.md
```

---

## Appium Testing

End-to-End tests are implemented using Appium.

### Requirements

- Node.js & npm
- Appium installed globally

```bash
npm install -g appium
```

### Run Appium Server

```bash
appium
```

### Execute Tests

```bash
cd appium_tests
npx mocha specs/auth.spec.js
npx mocha specs/cart.spec.js
```

Test logs and screenshots are stored in:

```
docs/results/
```

---

## Demo Video

A full demonstration video showing authentication, browsing, favorites, cart, and checkout is available in:

```
/video/demo.mp4
```

---

## Build APK

```bash
flutter build apk
```

The APK can be found in:

```
builds/apk/
```

---

## Notes

- This project focuses on functionality rather than UI perfection
- Appium tests may not fully pass but demonstrate execution and automation
- All required deliverables (video, logs, screenshots, APK) are included

---

## License

This project is created for **educational purposes only**.

---

**Last Updated:** December 2025

