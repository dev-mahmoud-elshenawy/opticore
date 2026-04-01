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
/// Manages and checks internet connectivity with caching, deduplication,
/// and network-adapter fallback.
///
/// ## Architecture
///
/// The handler uses a **two-layer** verification strategy:
///
/// 1. **Ping check** — [InternetConnection.hasInternetAccess] pings an external
///    host to confirm real internet access. Fast but can fail intermittently
///    on mobile networks (DNS timeouts, captive portals, slow handshake).
///
/// 2. **Network-adapter check** — [Connectivity] plugin checks whether Wi-Fi
///    or mobile data is active. Cheap and reliable, but does not prove real
///    internet access (e.g. connected to Wi-Fi with no upstream).
///
/// The two public check methods combine these layers differently:
///
/// | Method | Strategy |
/// |--------|----------|
/// | [isInternetConnected] | adapter first → ping to verify |
/// | [isGoogleInternetConnected] | ping first → adapter fallback if ping fails |
///
/// Both methods share a **5-second TTL cache** and a **deduplication guard**
/// so that rapid navigation or concurrent API calls never trigger redundant
/// checks.
///
/// ## Usage
///
/// ```dart
/// // One-shot check (default for NetworkHelper)
/// final online = await InternetConnectionHandler.checkInternetConnection(true);
///
/// // Real-time stream
/// InternetConnectionHandler.startListeningToConnectivity();
/// InternetConnectionHandler.internetConnectionStatusStream.listen((status) {
///   print(status == InternetStatus.connected ? 'online' : 'offline');
/// });
/// ```
///
/// ## Public API (non-breaking)
///
/// All public members keep their original signatures. Internal improvements
/// (caching, deduplication, fallback, timeout) are transparent to consumers.
class InternetConnectionHandler {
  // ---------------------------------------------------------------------------
  // Shared instance
  // ---------------------------------------------------------------------------

  /// Single [InternetConnection] instance used for both the status stream and
  /// on-demand ping checks. Using one instance avoids duplicate sockets and
  /// keeps the stream / check results consistent.
  static final InternetConnection _checker = InternetConnection();

  // ---------------------------------------------------------------------------
  // Stream & real-time status
  // ---------------------------------------------------------------------------

  /// Real-time stream of internet status changes.
  ///
  /// Emits [InternetStatus.connected] or [InternetStatus.disconnected].
  ///
  /// ```dart
  /// InternetConnectionHandler.internetConnectionStatusStream.listen((status) {
  ///   if (status == InternetStatus.connected) {
  ///     // online
  ///   } else {
  ///     // offline
  ///   }
  /// });
  /// ```
  static Stream<InternetStatus> get internetConnectionStatusStream =>
      _checker.onStatusChange;

  /// Whether the device is currently connected.
  ///
  /// Updated automatically when [startListeningToConnectivity] is active.
  /// Returns `false` until the first stream event arrives.
  static bool get isConnected => _isConnected;
  static bool _isConnected = false;

  /// Active subscription created by [startListeningToConnectivity].
  static StreamSubscription<InternetStatus>? _connectivitySubscription;

  /// Starts listening to connectivity changes and keeps the cache in sync.
  ///
  /// Safe to call multiple times — the previous subscription is cancelled.
  ///
  /// ```dart
  /// InternetConnectionHandler.startListeningToConnectivity();
  /// ```
  static void startListeningToConnectivity() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription =
        internetConnectionStatusStream.listen((status) {
      final connected = status == InternetStatus.connected;
      _isConnected = connected;
      _updateCache(connected);
    });
  }

  /// Stops listening to connectivity changes and frees resources.
  static void stopListeningToConnectivity() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }

  // ---------------------------------------------------------------------------
  // UI state
  // ---------------------------------------------------------------------------

  /// Whether the "No Internet" screen is currently displayed.
  ///
  /// Managed by the fallback screen widgets to avoid showing the screen
  /// repeatedly while the device remains offline.
  static bool isNoInternetSceneShown = false;

  // ---------------------------------------------------------------------------
  // Cache internals
  // ---------------------------------------------------------------------------

  /// Last known connectivity result (shared by all check methods).
  static bool _cachedIsConnected = false;

  /// When [_cachedIsConnected] was last written.
  static DateTime? _lastCheckTime;

  /// Results are trusted for this duration before a fresh check runs.
  static const Duration _cacheTtl = Duration(seconds: 5);

  /// Guards against overlapping checks — concurrent callers get the same
  /// [Future] instead of spawning parallel pings.
  static Completer<bool>? _activeCheck;

  /// Writes [connected] to the cache and stamps the current time.
  static void _updateCache(bool connected) {
    _cachedIsConnected = connected;
    _lastCheckTime = DateTime.now();
  }

  /// `true` when the cached result is still within [_cacheTtl].
  static bool get _isCacheValid =>
      _lastCheckTime != null &&
      DateTime.now().difference(_lastCheckTime!) < _cacheTtl;

  // ---------------------------------------------------------------------------
  // Public check methods
  // ---------------------------------------------------------------------------

  /// Routes to [isGoogleInternetConnected] or [isInternetConnected] based on
  /// the [isGoogle] flag.
  ///
  /// This is the main entry point used by [NetworkHelper] before every request.
  ///
  /// * `true`  → ping-first with network-adapter fallback
  /// * `false` → adapter-first with ping verification
  static Future<bool> checkInternetConnection(bool isGoogle) {
    return isGoogle
        ? isGoogleInternetConnected()
        : isInternetConnected();
  }

  /// **Adapter-first** connectivity check.
  ///
  /// ### Flow
  /// 1. Return cached result if TTL has not expired.
  /// 2. Check whether a network adapter (Wi-Fi / mobile) is active.
  /// 3. If active, verify real internet access via a 5-second ping.
  /// 4. Cache and return the result.
  ///
  /// Concurrent calls are deduplicated — only one check runs at a time.
  static Future<bool> isInternetConnected() async {
    if (_isCacheValid) {
      Logger.verbose('Using cached connection status: $_cachedIsConnected');
      return _cachedIsConnected;
    }

    return _deduplicatedCheck(() async {
      Logger.verbose('Checking internet connectivity status...');
      try {
        if (!await _hasNetworkAdapter()) {
          Logger.error('No network adapter (Wi-Fi / mobile) detected.');
          _updateCache(false);
          return false;
        }

        Logger.verbose(
            'Network adapter active, verifying internet access...');
        final hasAccess = await _pingWithTimeout();
        _updateCache(hasAccess);
        return hasAccess;
      } catch (e) {
        Logger.error('Connectivity check failed: $e');
        _updateCache(false);
        return false;
      }
    });
  }

  /// **Ping-first** connectivity check with network-adapter fallback.
  ///
  /// ### Flow
  /// 1. Return cached result if TTL has not expired.
  /// 2. Ping an external host (5-second timeout).
  /// 3. If the ping **succeeds** → connected.
  /// 4. If the ping **fails** but a network adapter is active → treat as
  ///    connected and let the actual HTTP request be the final judge.
  ///    This prevents false "no internet" errors caused by transient DNS
  ///    timeouts or slow handshakes on mobile networks.
  /// 5. If the ping fails **and** no adapter is active → offline.
  ///
  /// Concurrent calls are deduplicated — only one check runs at a time.
  static Future<bool> isGoogleInternetConnected() async {
    if (_isCacheValid) {
      Logger.verbose('Using cached connection status: $_cachedIsConnected');
      return _cachedIsConnected;
    }

    return _deduplicatedCheck(() async {
      Logger.verbose('Checking internet connectivity status...');
      try {
        final hasAccess = await _pingWithTimeout();
        if (hasAccess) {
          Logger.verbose('Internet access confirmed via ping.');
          _updateCache(true);
          return true;
        }

        // Ping failed — fall back to the network adapter before giving up.
        if (await _hasNetworkAdapter()) {
          Logger.verbose(
              'Ping failed but network adapter is active — treating as connected.');
          _updateCache(true);
          return true;
        }

        Logger.error('No internet connection detected.');
        _updateCache(false);
        return false;
      } catch (_) {
        Logger.error('No internet connection detected.');
        _updateCache(false);
        return false;
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  /// Ensures only one connectivity check runs at a time.
  ///
  /// If a check is already in-flight, concurrent callers receive the same
  /// [Future] instead of spawning duplicate pings.
  static Future<bool> _deduplicatedCheck(
      Future<bool> Function() check) async {
    if (_activeCheck != null && !_activeCheck!.isCompleted) {
      return _activeCheck!.future;
    }

    _activeCheck = Completer<bool>();
    try {
      final result = await check();
      _activeCheck!.complete(result);
      return result;
    } catch (e) {
      _activeCheck!.complete(false);
      return false;
    }
  }

  /// Returns `true` when a Wi-Fi or mobile network adapter is active.
  static Future<bool> _hasNetworkAdapter() async {
    final results = await Connectivity().checkConnectivity();
    return results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi);
  }

  /// Pings an external host with a **5-second timeout**.
  ///
  /// Returns `false` on timeout or exception instead of hanging indefinitely.
  static Future<bool> _pingWithTimeout() async {
    try {
      return await _checker.hasInternetAccess
          .timeout(const Duration(seconds: 5), onTimeout: () => false);
    } catch (_) {
      return false;
    }
  }
}
