# Appium Test Cases Documentation

## Overview

This document describes the automated end-to-end tests for the Laza e-commerce mobile app using Appium.

## Test Environment

### Tools & Versions

- **Appium:** 2.0+
- **Node.js:** 18.0+
- **Test Framework:** WebDriverIO / Appium Client
- **Language:** JavaScript/TypeScript
- **Drivers:**
  - Android: UiAutomator2
  - iOS: XCUITest

### Pre-requisites

1. Appium server installed and running
2. Android SDK or Xcode configured
3. Device/Emulator connected and running
4. App installed on device/emulator

## Test Cases

### Test Case 1: Authentication Flow

**Test ID:** AUTH_001  
**Priority:** High  
**Objective:** Verify user can sign up, log in, and access the home screen

#### Pre-conditions

- App is installed on device
- Device is connected and accessible
- Appium server is running on port 4723
- No existing user session (fresh app install or logged out)

#### Test Steps

1. Launch the Laza e-commerce app
2. Wait for splash screen to load (if present)
3. Navigate to Sign Up screen
4. Enter valid email address (e.g., `test_user_${timestamp}@example.com`)
5. Enter valid password (minimum 6 characters)
6. Tap "Sign Up" button
7. Wait for sign-up completion
8. Verify navigation to Home screen
9. Log out (if logout option available)
10. Navigate to Login screen
11. Enter the same email address
12. Enter the same password
13. Tap "Login" button
14. Wait for login completion
15. Verify successful navigation to Home screen
16. Verify home screen elements are visible (product list, search, etc.)

#### Expected Results

- Sign up completes successfully without errors
- User is automatically logged in after sign up
- Home screen is displayed with product listings
- Login with same credentials is successful
- Home screen loads properly after login
- All expected UI elements are visible

#### Test Data

```javascript
{
  email: `test${Date.now()}@example.com`,
  password: "Test123!",
  expectedHomeScreenTitle: "Home" or "Products"
}
```

#### Element Locators

```javascript
// Sign Up Screen
const emailInput = '//android.widget.EditText[@resource-id="email_input"]';
const passwordInput = '//android.widget.EditText[@resource-id="password_input"]';
const signUpButton = '//android.widget.Button[@text="Sign Up"]';

// Login Screen
const loginEmailInput = '//android.widget.EditText[@resource-id="login_email"]';
const loginPasswordInput = '//android.widget.EditText[@resource-id="login_password"]';
const loginButton = '//android.widget.Button[@text="Login"]';

// Home Screen
const homeTitle = '//android.widget.TextView[@text="Home"]';
const productList = '//android.widget.RecyclerView';
```

#### Validation Points

✓ Sign up form accepts valid email and password  
✓ Sign up button becomes enabled after entering valid credentials  
✓ Success message or navigation occurs after sign up  
✓ Home screen displays after successful authentication  
✓ Login form accepts credentials  
✓ Login succeeds with correct credentials  
✓ Home screen shows product list after login

---

### Test Case 2: Add to Cart Flow

**Test ID:** CART_001  
**Priority:** High  
**Objective:** Verify user can add a product to cart and view it in the cart screen

#### Pre-conditions

- App is installed and running
- User is authenticated (logged in)
- User is on the Home screen
- At least one product is available in the product list
- Cart is empty (or test handles existing cart items)

#### Test Steps

1. Verify user is on Home screen
2. Wait for product list to load
3. Identify and tap on the first available product
4. Wait for Product Detail screen to load
5. Verify product information is displayed:
   - Product image
   - Product title
   - Product price
   - Product description
6. Locate "Add to Cart" button
7. Tap "Add to Cart" button
8. Wait for confirmation (toast message or visual feedback)
9. Navigate to Cart screen (via bottom navigation or menu)
10. Wait for Cart screen to load
11. Verify the added product appears in the cart
12. Verify product details in cart match:
    - Product title
    - Product price
    - Quantity (default: 1)
13. Verify cart subtotal is calculated correctly

#### Expected Results

- Product detail screen loads with all information
- "Add to Cart" button is clickable
- Cart successfully updates after adding product
- Confirmation message appears
- Navigation to cart screen is successful
- Added product is visible in cart
- Product information in cart is accurate
- Quantity defaults to 1
- Subtotal calculation is correct

#### Test Data

```javascript
{
  productIndex: 0, // First product in list
  expectedQuantity: 1,
  cartScreenTitle: "Cart" or "My Cart"
}
```

#### Element Locators

```javascript
// Home Screen
const productListItem = '//android.view.ViewGroup[@resource-id="product_item"][1]';

// Product Detail Screen
const productTitle = '//android.widget.TextView[@resource-id="product_title"]';
const productPrice = '//android.widget.TextView[@resource-id="product_price"]';
const addToCartButton = '//android.widget.Button[@text="Add to Cart"]';

// Cart Screen
const cartIcon = '//android.widget.ImageView[@content-desc="Cart"]';
const cartItemTitle = '//android.widget.TextView[@resource-id="cart_item_title"]';
const cartItemPrice = '//android.widget.TextView[@resource-id="cart_item_price"]';
const cartItemQuantity = '//android.widget.TextView[@resource-id="cart_item_quantity"]';
const cartSubtotal = '//android.widget.TextView[@resource-id="cart_subtotal"]';
```

#### Validation Points

✓ Product detail screen displays correctly  
✓ Add to Cart button is functional  
✓ Cart icon/badge updates to show item count  
✓ Cart screen navigation works  
✓ Product appears in cart list  
✓ Product details match in cart  
✓ Quantity is set to 1 by default  
✓ Subtotal calculation is accurate

---

## Running the Tests

### Setup

1. Install dependencies:
```bash
cd appium_tests
npm install
```

2. Start Appium server:
```bash
appium
```

3. Configure capabilities in `config.js`:
```javascript
// For Android
{
  platformName: 'Android',
  deviceName: 'emulator-5554',
  app: '/path/to/app.apk',
  automationName: 'UiAutomator2'
}

// For iOS
{
  platformName: 'iOS',
  deviceName: 'iPhone 14',
  app: '/path/to/app.app',
  automationName: 'XCUITest'
}
```

### Execute All Tests

```bash
npm test
```

### Execute Individual Tests

```bash
# Run authentication test only
npm run test:auth

# Run cart test only
npm run test:cart
```

### Execute with Specific Configuration

```bash
# Run on Android
npm run test:android

# Run on iOS
npm run test:ios
```

## Test Configuration

### config.js

```javascript
exports.config = {
  runner: 'local',
  port: 4723,
  specs: [
    './specs/**/*.spec.js'
  ],
  maxInstances: 1,
  capabilities: [{
    platformName: 'Android',
    'appium:deviceName': 'Android Emulator',
    'appium:app': './app/laza-ecommerce.apk',
    'appium:automationName': 'UiAutomator2',
    'appium:newCommandTimeout': 240
  }],
  logLevel: 'info',
  bail: 0,
  waitforTimeout: 10000,
  connectionRetryTimeout: 120000,
  connectionRetryCount: 3,
  framework: 'mocha',
  reporters: ['spec'],
  mochaOpts: {
    ui: 'bdd',
    timeout: 60000
  }
};
```

## Test Results Interpretation

### Success Criteria

- All test steps execute without errors
- All assertions pass
- Expected elements are found and interacted with
- Navigation flows work as expected
- Test completes within timeout period

### Common Failure Reasons

1. **Element not found:**
   - Element locator has changed
   - Element not yet rendered (timing issue)
   - Element is hidden or off-screen

2. **Timeout:**
   - Network delay for API calls
   - Slow device/emulator
   - App performance issues

3. **Assertion failure:**
   - Unexpected app behavior
   - UI text mismatch
   - Calculation error

4. **Navigation failure:**
   - Button not clickable
   - Navigation logic changed
   - Permission dialog blocking

## Troubleshooting

### Issue: Appium server connection failed

**Solution:**
- Verify Appium server is running
- Check port 4723 is not in use
- Restart Appium server

### Issue: Device not detected

**Solution:**
```bash
# For Android
adb devices

# For iOS
xcrun simctl list
```

### Issue: App not installed

**Solution:**
```bash
# Android
adb install path/to/app.apk

# iOS
xcrun simctl install booted path/to/app.app
```

### Issue: Element locator not working

**Solution:**
- Use Appium Inspector to identify correct locators
- Try alternative locator strategies (id, xpath, accessibility id)
- Add explicit waits for element visibility

### Issue: Test timeout

**Solution:**
- Increase `waitforTimeout` in config
- Add explicit waits before critical steps
- Check app performance on device

## Best Practices

1. **Use explicit waits:** Always wait for elements before interaction
2. **Unique test data:** Use timestamps in test emails to avoid conflicts
3. **Clean state:** Reset app state between test runs when possible
4. **Robust locators:** Prefer resource-id or accessibility-id over xpath
5. **Error handling:** Implement try-catch blocks for critical steps
6. **Screenshots:** Capture screenshots on failure for debugging
7. **Logging:** Log test steps for easier debugging

## Maintenance

### Updating Tests

When UI changes occur:
1. Update element locators
2. Adjust wait times if needed
3. Update expected values
4. Re-run tests to verify

### Adding New Tests

1. Create new spec file in `specs/` directory
2. Follow existing test structure
3. Document test case in this file
4. Update package.json scripts if needed

## Test Metrics

### Expected Execution Time

- Authentication Test: ~30-45 seconds
- Cart Test: ~25-35 seconds
- Total Suite: ~60-90 seconds

### Coverage

These tests cover:
- ✓ User authentication (sign up, login)
- ✓ Product navigation
- ✓ Add to cart functionality
- ✓ Cart view functionality

Not covered (out of MVP scope):
- ✗ Add to favorites
- ✗ Checkout flow
- ✗ Profile management
- ✗ Search functionality

## Contact & Support

For test-related issues:
1. Check this documentation
2. Review test logs in `/docs/results`
3. Consult Appium documentation
4. Contact course instructor

---

**Last Updated:** December 2025  
**Test Framework Version:** Appium 2.0+  
**Maintained by:** Mobile App Development Course Team
