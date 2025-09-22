import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Application configuration and environment settings
/// 
/// Centralizes all app-wide configuration values including
/// API endpoints, feature flags, and environment-specific settings.
class AppConfig {
  // Private constructor to prevent instantiation
  AppConfig._();
  
  /// Application metadata
  static const String appName = 'Market-Mate';
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;
  
  /// Environment detection
  static bool get isDevelopment => kDebugMode;
  static bool get isProduction => kReleaseMode;
  static bool get isTesting => const bool.fromEnvironment('TESTING');
  
  /// API Configuration
  static String get apiBaseUrl {
    if (isDevelopment) {
      return const String.fromEnvironment(
        'DEV_API_URL',
        defaultValue: 'http://localhost:8080/api/v1',
      );
    }
    return const String.fromEnvironment(
      'PROD_API_URL', 
      defaultValue: 'https://api.market-mate.co.kr/v1',
    );
  }
  
  /// Network timeouts (in milliseconds)
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;
  
  /// Pagination defaults
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  /// Location services
  static const double defaultLocationAccuracy = 100.0; // meters
  static const int locationTimeoutSeconds = 30;
  
  /// Firebase options placeholder
  /// Note: Replace with actual Firebase configuration
  /// Run `flutterfire configure` to generate firebase_options.dart
  static FirebaseOptions? get firebaseOptions {
    // This will be replaced by actual Firebase configuration
    // For now, return null to allow development without Firebase setup
    return null;
  }
  
  /// Feature flags for A/B testing and gradual rollouts
  static bool get enableAIRecommendations => true;
  static bool get enableVoiceInterface => true;
  static bool get enablePushNotifications => true;
  static bool get enableAnalytics => isProduction;
  static bool get enableCrashlytics => isProduction;
  
  /// AI/ML Configuration
  static const double minCompatibilityScore = 0.6;
  static const int maxRecommendations = 10;
  static const int aiRequestTimeoutSeconds = 15;
  
  /// UI/UX Configuration
  static const int animationDurationMs = 300;
  static const double borderRadiusDefault = 12.0;
  static const double elevationDefault = 4.0;
  
  /// Cache settings
  static const int imageCacheMaxAge = 7; // days
  static const int dataCacheMaxAge = 1; // hours
  
  /// Logging configuration
  static bool get enableDetailedLogging => isDevelopment;
  static bool get enableNetworkLogging => isDevelopment;
  
  /// Security settings
  static const int maxLoginAttempts = 5;
  static const int sessionTimeoutMinutes = 60;
  
  /// Business logic constants
  static const int minExperienceYears = 1;
  static const int maxExperienceYears = 50;
  static const double minRatingThreshold = 3.0;
  static const double maxDistanceKm = 100.0;
  
  /// Validation settings
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 500;
  
  /// External service URLs
  static String get termsOfServiceUrl => 'https://market-mate.co.kr/terms';
  static String get privacyPolicyUrl => 'https://market-mate.co.kr/privacy';
  static String get supportUrl => 'https://market-mate.co.kr/support';
}