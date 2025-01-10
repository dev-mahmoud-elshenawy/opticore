part of '../util_import.dart';

/// A utility class for managing and checking internet connectivity status.
///
/// The `InternetConnectionHandler` class provides methods to check the device's current internet connectivity status. It first checks the device's network connection (whether mobile data or Wi-Fi is available) and then uses an external checker to verify actual internet access. The class also supports caching the connectivity status to avoid redundant checks, improving performance. Additionally, it manages the UI state for internet connectivity by tracking whether the "No Internet Scene" is currently displayed.
///
/// ## Key Features:
/// - **Caching**: The internet connectivity status is cached to reduce redundant checks and improve performance.
/// - **Connectivity Check**: The class verifies the internet connection using both the device's network connection and an external checker to confirm internet access.
/// - **Error Handling**: The class includes robust error handling to manage any issues while checking the connectivity.
///
/// ## How to Use:
/// The `InternetConnectionHandler.isInternetConnected()` method is the main entry point for checking the internet connection status. It returns a `Future<bool>` indicating whether the device is connected to the internet, and it caches the result for subsequent checks.
///
/// ### Example Usage:
/// ```dart
/// bool isConnected = await InternetConnectionHandler.isInternetConnected();
/// if (isConnected) {
///   // Proceed with internet-dependent actions
/// } else {
///   // Handle no internet connection scenario
/// }
/// ```
class InternetConnectionHandler {
  /// Instance of the [InternetConnection] class used for checking actual internet access.
  static final InternetConnection _checker = InternetConnection();

  /// Flag indicating whether the "No Internet Scene" has been displayed.
  /// This can be used to manage the UI state, ensuring that the "No Internet" message
  /// is not repeatedly shown while the device remains disconnected.
  static bool isNoInternetSceneShown = false;

  /// Cached result of the internet connectivity check. This flag helps to avoid
  /// unnecessary repeated connectivity checks when the status has not changed.
  static bool _cachedIsConnected = false;

  /// Checks whether the device is currently connected to the internet.
  ///
  /// This method first checks the cached connectivity status. If the cached status is
  /// unavailable or the connection status has changed, it checks the device's connectivity
  /// using the [Connectivity] plugin (whether on mobile data or Wi-Fi). Then, it verifies
  /// actual internet access using an external checker.
  ///
  /// This method returns a [Future<bool>] indicating whether the device is connected to the internet.
  ///
  /// ## Flow:
  /// 1. If the cached status is available, it is returned immediately.
  /// 2. If the cached status is unavailable or has changed, the method checks the device's network connectivity.
  /// 3. If the device is connected to a network (Wi-Fi or mobile), the method checks for actual internet access.
  ///
  /// ### Returns:
  /// A [Future<bool>] that resolves to `true` if the device is connected to the internet, or `false` otherwise.
  static Future<bool> isInternetConnected() async {
    // Return cached connection status if available
    if (_cachedIsConnected) {
      Logger.verbose('Using cached internet connection status: $_cachedIsConnected');
      return _cachedIsConnected;
    }

    Logger.verbose('Checking internet connectivity status...');

    try {
      // Check for network connectivity (Wi-Fi or mobile)
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        Logger.verbose('Network connection detected (Mobile or Wi-Fi), checking actual internet access...');
        // Check for actual internet access using the external checker
        _cachedIsConnected = await _checkInternetWithChecker();
        return _cachedIsConnected;
      } else {
        Logger.error('No network connection (Mobile or Wi-Fi) detected.');
        _cachedIsConnected = false;
        return _cachedIsConnected;
      }
    } catch (e) {
      Logger.error('Error occurred while checking connectivity: $e');
      _cachedIsConnected = false;
      return _cachedIsConnected;
    }
  }

  /// Verifies the actual internet access by using the [InternetConnection] instance.
  ///
  /// This method checks if the device has internet access by pinging an external service
  /// to confirm that the device is connected to the internet, even if it has network connectivity.
  ///
  /// ### Returns:
  /// A [Future<bool>] that resolves to `true` if the device has internet access, or `false` otherwise.
  static Future<bool> _checkInternetWithChecker() async {
    try {
      bool result = await _checker.hasInternetAccess;
      if (result) {
        Logger.verbose('Internet access is available.');
        return true;
      } else {
        Logger.verbose('No internet access detected.');
        return false;
      }
    } catch (e) {
      Logger.error('Error occurred while checking internet access: $e');
      return false;
    }
  }
}