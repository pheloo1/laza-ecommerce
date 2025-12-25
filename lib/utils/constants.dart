import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF2E2E5D);
  static const Color accent = Color(0xFFFF6584);
  static const Color background = Color(0xFFF9F9F9);
  static const Color inputBackground = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF1D1D1D);
  static const Color textSecondary = Color(0xFF8F8F8F);
  static const Color border = Color(0xFFE5E5E5);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF5252);
}

class AppStrings {
  static const String appName = 'Laza';
  static const String welcomeTitle = 'Welcome to Laza';
  static const String welcomeSubtitle = 'Your favorite shopping destination';
  
  // Auth
  static const String login = 'Login';
  static const String signUp = 'Sign Up';
  static const String logout = 'Logout';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String resetPassword = 'Reset Password';
  static const String dontHaveAccount = "Don't have an account?";
  static const String alreadyHaveAccount = 'Already have an account?';
  
  // Home
  static const String home = 'Home';
  static const String products = 'Products';
  static const String search = 'Search products...';
  
  // Product
  static const String addToCart = 'Add to Cart';
  static const String addToFavorites = 'Add to Favorites';
  static const String removeFromFavorites = 'Remove from Favorites';
  static const String productDetails = 'Product Details';
  
  // Cart
  static const String cart = 'Cart';
  static const String myCart = 'My Cart';
  static const String emptyCart = 'Your cart is empty';
  static const String subtotal = 'Subtotal';
  static const String checkout = 'Checkout';
  
  // Favorites
  static const String favorites = 'Favorites';
  static const String myFavorites = 'My Favorites';
  static const String emptyFavorites = 'No favorites yet';
  
  // Profile
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  
  // Messages
  static const String success = 'Success';
  static const String error = 'Error';
  static const String loading = 'Loading...';
  static const String addedToCart = 'Added to cart';
  static const String removedFromCart = 'Removed from cart';
  static const String addedToFavorites = 'Added to favorites';
  static const String removedFromFavorites = 'Removed from favorites';
  static const String orderPlaced = 'Order placed successfully!';
}

class AppSizes {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  
  static const double borderRadius = 12.0;
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusLarge = 16.0;
  
  static const double iconSize = 24.0;
  static const double iconSizeSmall = 20.0;
  static const double iconSizeLarge = 32.0;
}

class ApiEndpoints {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1';
  static const String products = '/products';
  static const String product = '/products';
  static const String categories = '/categories';
}
