# Firebase Setup Guide

This guide will walk you through setting up Firebase for the Laza e-commerce mobile app.

## Table of Contents

1. [Create Firebase Project](#create-firebase-project)
2. [Add Android App](#add-android-app)
3. [Add iOS App](#add-ios-app)
4. [Enable Authentication](#enable-authentication)
5. [Setup Firestore Database](#setup-firestore-database)
6. [Configure Security Rules](#configure-security-rules)
7. [Test Configuration](#test-configuration)

## Prerequisites

- Google account
- Firebase CLI installed (optional but recommended)
- Basic understanding of Firebase services

## Create Firebase Project

### Step 1: Access Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Sign in with your Google account
3. Click **"Add project"** or **"Create a project"**

### Step 2: Project Configuration

1. **Project name:** Enter `laza-ecommerce` (or your preferred name)
2. Click **Continue**
3. **Google Analytics:** 
   - Enable Google Analytics (optional)
   - Select or create an Analytics account
4. Click **Create project**
5. Wait for project creation (usually takes 30-60 seconds)
6. Click **Continue** when ready

## Add Android App

### Step 1: Register Android App

1. In Firebase Console, click the **Android icon** or **"Add app"**
2. Fill in the required information:
   - **Android package name:** `com.laza.ecommerce` (must match your Flutter app)
   - **App nickname:** `Laza Android` (optional)
   - **Debug signing certificate SHA-1:** (optional for now)

3. Click **Register app**

### Step 2: Download Configuration File

1. Download `google-services.json`
2. Place it in your Flutter project:
   ```
   android/app/google-services.json
   ```

### Step 3: Configure Android Project

Add Firebase SDK to your Android project files:

**File: `android/build.gradle`**

```gradle
buildscript {
    dependencies {
        // Add this line
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

**File: `android/app/build.gradle`**

```gradle
// Add at the bottom of the file
apply plugin: 'com.google.gms.google-services'

android {
    defaultConfig {
        // Make sure these are set
        minSdkVersion 21
        targetSdkVersion 33
    }
}
```

## Add iOS App

### Step 1: Register iOS App

1. In Firebase Console, click the **iOS icon** or **"Add app"**
2. Fill in the required information:
   - **iOS bundle ID:** `com.laza.ecommerce` (must match your Flutter app)
   - **App nickname:** `Laza iOS` (optional)
   - **App Store ID:** (leave blank for now)

3. Click **Register app**

### Step 2: Download Configuration File

1. Download `GoogleService-Info.plist`
2. Open your Flutter project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```
3. Drag `GoogleService-Info.plist` into the `Runner` folder in Xcode
4. Make sure **"Copy items if needed"** is checked
5. Select **Runner** as the target

### Step 3: Configure iOS Project

**File: `ios/Podfile`**

Ensure you have:

```ruby
platform :ios, '12.0'

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

Run pod install:

```bash
cd ios
pod install
cd ..
```

## Enable Authentication

### Step 1: Navigate to Authentication

1. In Firebase Console, click **Build** → **Authentication**
2. Click **Get started**

### Step 2: Enable Email/Password

1. Click on **Sign-in method** tab
2. Find **Email/Password** in the providers list
3. Click to expand
4. Toggle **Enable**
5. Click **Save**

### Email Link Sign-in (Optional)

If you want to enable passwordless email link sign-in:
1. Toggle **Email link (passwordless sign-in)**
2. Click **Save**

## Setup Firestore Database

### Step 1: Create Database

1. In Firebase Console, click **Build** → **Firestore Database**
2. Click **Create database**

### Step 2: Choose Security Mode

**For Development:**
- Select **Start in test mode**
- This allows read/write access for 30 days
- We'll add proper rules later

**Location:**
- Choose a location close to your users
- Example: `us-central1` or `europe-west1`

3. Click **Enable**

### Step 3: Initial Collections

You don't need to create collections manually. They will be created automatically when the app first writes data. However, you can preview the structure:

**Expected Collections:**
- `users` - User profile data
- `carts` - Shopping cart items
- `favorites` - Favorited products

## Configure Security Rules

### Step 1: Create firestore.rules File

Create a file named `firestore.rules` in your project root:

```rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper function to check if user is authenticated
    function isAuthenticated() {
      return request.auth != null;
    }
    
    // Helper function to check if user owns the document
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    
    // Users collection
    match /users/{userId} {
      // Users can read and write only their own document
      allow read, write: if isAuthenticated() && isOwner(userId);
    }
    
    // Carts collection
    match /carts/{userId}/items/{itemId} {
      // Users can read and write only their own cart
      allow read, write: if isAuthenticated() && isOwner(userId);
    }
    
    // Favorites collection
    match /favorites/{userId}/items/{itemId} {
      // Users can read and write only their own favorites
      allow read, write: if isAuthenticated() && isOwner(userId);
    }
  }
}
```

### Step 2: Deploy Rules

**Option A: Using Firebase Console**

1. Go to **Firestore Database** → **Rules** tab
2. Copy and paste the rules above
3. Click **Publish**

**Option B: Using Firebase CLI**

1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Login to Firebase:
   ```bash
   firebase login
   ```

3. Initialize Firebase in your project:
   ```bash
   firebase init firestore
   ```
   - Select your Firebase project
   - Accept default file names

4. Replace content of `firestore.rules` with the rules above

5. Deploy:
   ```bash
   firebase deploy --only firestore:rules
   ```

## Test Configuration

### Test Authentication

Create a simple Flutter test to verify Firebase is working:

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> testFirebase() async {
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Test Authentication
  final auth = FirebaseAuth.instance;
  print('Firebase Auth initialized: ${auth != null}');
  
  // Test Firestore
  final firestore = FirebaseFirestore.instance;
  print('Firestore initialized: ${firestore != null}');
}
```

### Verify in Firebase Console

1. **Authentication:**
   - Go to Authentication → Users
   - After signing up in the app, you should see users here

2. **Firestore:**
   - Go to Firestore Database → Data
   - After using the app, you should see collections populated

## Common Issues and Solutions

### Issue 1: "Default FirebaseApp is not initialized"

**Solution:**
```dart
// Make sure this is in your main.dart before runApp()
await Firebase.initializeApp();
```

### Issue 2: Android build fails with "google-services.json not found"

**Solution:**
- Verify `google-services.json` is in `android/app/` directory
- Run `flutter clean`
- Run `flutter pub get`

### Issue 3: iOS build fails

**Solution:**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
```

### Issue 4: Firestore permission denied

**Solution:**
- Check your Firestore rules
- Make sure user is authenticated
- Verify userId matches in the rules

### Issue 5: SHA-1 certificate needed for Google Sign-In

**Get Debug SHA-1:**
```bash
cd android
./gradlew signingReport
```

**Get Release SHA-1:**
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

Add SHA-1 in Firebase Console → Project Settings → Your Android App

## Environment Variables

For sensitive information, create a `.env` file (add to `.gitignore`):

```env
FIREBASE_API_KEY=your_api_key
FIREBASE_APP_ID=your_app_id
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_PROJECT_ID=laza-ecommerce
```

Use the `flutter_dotenv` package to load these values.

## Firebase Configuration Files

### firebase.json

Create `firebase.json` in project root:

```json
{
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  }
}
```

### firestore.indexes.json

Create `firestore.indexes.json`:

```json
{
  "indexes": [],
  "fieldOverrides": []
}
```

## Security Best Practices

1. **Never commit sensitive files:**
   - Add to `.gitignore`:
     ```
     # Firebase
     google-services.json
     GoogleService-Info.plist
     .env
     ```

2. **Use environment-specific projects:**
   - Development Firebase project
   - Production Firebase project

3. **Implement proper security rules:**
   - Always validate userId
   - Use authentication checks
   - Add data validation

4. **Monitor usage:**
   - Set up billing alerts
   - Monitor Firestore usage
   - Track authentication attempts

## Next Steps

After completing Firebase setup:

1. ✅ Run your Flutter app
2. ✅ Test sign up/login
3. ✅ Test Firestore read/write
4. ✅ Verify data in Firebase Console
5. ✅ Deploy security rules
6. ✅ Set up monitoring

## Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [Firebase CLI Reference](https://firebase.google.com/docs/cli)

## Support

If you encounter issues:

1. Check [Firebase Status Dashboard](https://status.firebase.google.com/)
2. Review [FlutterFire Issues](https://github.com/firebase/flutterfire/issues)
3. Check Firebase Console logs
4. Verify all configuration files are in place

---

**Setup completed?** Proceed to run the app with `flutter run`
