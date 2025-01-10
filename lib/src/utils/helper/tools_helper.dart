part of '../util_import.dart';

/// A helper class containing utility functions to manage common tasks
/// and ensure efficient execution of actions based on conditions, such as
/// controlling the frequency of repeated actions and ensuring internet
/// connectivity before executing a function.
///
/// The `ToolsHelper` class provides simple yet powerful methods to manage
/// recurring actions and ensure that specific actions are only performed
/// under certain conditions, improving performance and reliability of the app.
///
/// **Main Features:**
/// - Control the execution of actions to prevent repeated triggers within a specific time frame.
/// - Ensure internet connectivity before executing functions, with automatic checks for network availability.
///
/// This class is designed to be used across various parts of your app where you need
/// to control repeated actions and network-dependent operations.
///
/// Example usage:
/// ```dart
/// ToolsHelper.stopRepeating(action: () => performAction(), duration: Duration(seconds: 15));
/// ToolsHelper.triggerWithInternet(() => fetchDataFromServer());
/// ```
class ToolsHelper {
  // Static variable to store the last time the action was executed
  static DateTime? _lastActionTime;

  /// Ensures that the provided action is executed only once within a specified
  /// duration. If the action is triggered again within that duration, it will
  /// be ignored.
  ///
  /// This method is useful for rate-limiting actions to prevent them from being
  /// executed too frequently, such as avoiding repeated API requests, button presses,
  /// or other potentially expensive operations.
  ///
  /// [action] - The function to be executed. If `null`, no action will be triggered.
  /// [duration] - The minimum duration between consecutive executions. Defaults to 10 seconds if not specified.
  ///
  /// Returns `true` if the action was executed, and `false` if the action was skipped due to the time condition.
  ///
  /// **Example:**
  /// ```dart
  /// ToolsHelper.stopRepeating(action: () => someFunction(), duration: Duration(seconds: 10));
  /// ```
  static bool stopRepeating({
    Function()? action,
    Duration? duration,
  }) {
    // Default duration to 10 seconds if no duration is provided
    duration ??= Duration(seconds: 10);

    // Get the current time
    DateTime now = DateTime.now();

    // Check if the action is allowed to run based on the last triggered time
    if (_lastActionTime == null || now.difference(_lastActionTime!) > duration) {
      _lastActionTime = now; // Update the last action time

      // Execute the action if provided
      if (action != null) {
        action();
      }
      return true; // Action executed successfully
    }

    // If action was executed recently, return false to indicate no action
    return false;
  }

  /// A utility method to trigger a function if the device has an active internet connection.
  ///
  /// This method ensures that a function is only executed if the device is connected to the internet,
  /// preventing errors or delays that might occur when attempting to perform network operations without
  /// an active connection.
  ///
  /// It first checks the device’s network status using the [InternetConnectionHandler]. If the device is
  /// connected to the internet, the provided [action] is executed. If the device is not connected, a log message
  /// is recorded to indicate that the action is not executed due to lack of connectivity.
  ///
  /// [action] - The function that will be executed if the device is connected to the internet.
  ///
  /// **Example:**
  /// ```dart
  /// ToolsHelper.triggerWithInternet(() => fetchDataFromServer());
  /// ```
  static Future<void> triggerWithInternet(Function() action) async {
    // Check if the device has internet connectivity
    bool isConnected = await InternetConnectionHandler.isInternetConnected();

    if (isConnected) {
      // If connected, trigger the provided action
      action();
    } else {
      // If not connected, log a message
      Logger.verbose('Not Internet Connected Yet');
    }
  }
}