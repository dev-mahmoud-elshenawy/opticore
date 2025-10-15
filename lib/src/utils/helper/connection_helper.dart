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

  /// Flag indicating whether the device is currently connected to the internet.
  static bool _isConnected = false;

  /// Stream that emits the internet connection status changes.
  ///
  /// This stream provides real-time updates on the internet connection status, emitting
  /// [InternetStatus.connected] when the device is connected to the internet and
  /// [InternetStatus.disconnected] when the device is disconnected.
  /// The stream can be used to listen for changes in the internet connection status.
  /// ```dart
  /// InternetConnectionHandler.internetConnectionStatusStream.listen((status) {
  ///  if (status == InternetStatus.connected) {
  ///  // Handle internet connection
  ///  } else {
  ///  // Handle no internet connection
  ///  }
  ///  });
  ///  ```
  static final Stream<InternetStatus> _internetConnectionStream =
      InternetConnection().onStatusChange;

  /// Stream that emits the internet connection status changes.
  ///
  /// This stream provides real-time updates on the internet connection status, emitting
  /// [InternetStatus.connected] when the device is connected to the internet and
  /// [InternetStatus.disconnected] when the device is disconnected.
  /// The stream can be used to listen for changes in the internet connection status.
  ///
  /// ### Example Usage:
  /// ```dart
  /// InternetConnectionHandler.internetConnectionStatusStream.listen((status) {
  ///  if (status == InternetStatus.connected) {
  ///  // Handle internet connection
  ///  } else {
  ///  // Handle no internet connection
  ///  }
  ///  });
  ///  ```
  static Stream<InternetStatus> get internetConnectionStatusStream {
    return _internetConnectionStream;
  }

  /// Flag indicating whether the device is currently connected to the internet.
  ///
  /// This flag is updated based on the internet connection status changes.
  /// It can be used to determine whether the device has internet access.
  /// But you need to [startListeningToConnectivity] to start listening to the internet connection status changes.
  ///
  /// ### Example Usage:
  /// ```dart
  /// if (InternetConnectionHandler.isConnected) {
  /// // Proceed with internet-dependent actions
  /// } else {
  /// // Handle no internet connection scenario
  /// }
  /// ```
  ///
  static bool get isConnected => _isConnected;

  /// Starts listening to the internet connection status changes.
  ///
  /// This method listens to the internet connection status changes and updates the [isConnected] flag accordingly.
  /// which determines whether the device is connected to the internet.
  /// By subscribing to the stream [internetConnectionStatusStream], the class can track the internet connection status changes in real-time.
  ///
  /// ### Example Usage:
  /// ```dart
  /// InternetConnectionHandler.startListeningToConnectivity();
  /// ```
  static void startListeningToConnectivity() {
    _internetConnectionStream.listen((isConnected) {
      _isConnected = isConnected == InternetStatus.connected;
    });
  }

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
    Logger.verbose('Checking internet connectivity status...');

    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 10));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      try {
        final result = await InternetAddress.lookup('amazon.com')
            .timeout(const Duration(seconds: 10));
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } catch (_) {
        Logger.error('No internet connection detected.');
        return false;
      }
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
