part of '../util_import.dart';

/// A utility class that provides a safe way to execute asynchronous operations
/// without throwing exceptions.
///
/// The `SafeCall` class helps prevent app crashes by handling errors that occur
/// during asynchronous operations. It allows you to execute a future operation
class SafeCall {
  /// Executes a future operation safely, returning a default value if an error occurs.
  ///
  /// **Example Usage:**
  /// ```dart
  /// final result = await SafeCall.execute(() async => fetchData(), []);
  /// ```
  ///
  /// **Parameters:**
  /// - [operation]: A function that returns a `Future<T>`.
  /// - 'defaultValue': A fallback value returned if the operation fails.
  ///
  /// **Returns:** The result of the operation if successful, otherwise `defaultValue`.
  static Future<T?> execute<T>(
    Future<T> Function() operation, [
    T? defaultValue,
    Duration? timeout,
  ]) async {
    try {
      final future = operation();
      return timeout != null ? await future.timeout(timeout) : await future;
    } catch (e, stackTrace) {
      Logger.error('SafeCall Error: $e\n$stackTrace');
      return defaultValue;
    }
  }
}
