import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Dependency injection container for managing app-wide services
/// 
/// Initializes and provides access to singleton services like
/// local storage, secure storage, and other core dependencies.
class DependencyInjection {
  // Private constructor
  DependencyInjection._();
  
  static SharedPreferences? _sharedPreferences;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainItemAccessibility.first_unlock_this_device,
    ),
  );
  
  /// Initialize all dependencies
  static Future<void> initialize() async {
    await _initializeStorageServices();
    // Add other service initializations here
  }
  
  /// Initialize storage services
  static Future<void> _initializeStorageServices() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  
  /// Get shared preferences instance
  static SharedPreferences get sharedPreferences {
    if (_sharedPreferences == null) {
      throw Exception('SharedPreferences not initialized. Call DependencyInjection.initialize() first.');
    }
    return _sharedPreferences!;
  }
  
  /// Get secure storage instance
  static FlutterSecureStorage get secureStorage => _secureStorage;
}