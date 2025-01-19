part of '../util_import.dart';

/// A singleton helper class to manage async operations sequentially and handle animation cancellations.
class AsyncHelper {
  /// Private constructor to prevent external instantiation.
  AsyncHelper._();

  /// The singleton instance.
  static final AsyncHelper instance = AsyncHelper._();

  /// A map to store active locks for keys.
  final _locks = HashMap<dynamic, Completer>();

  /// Invokes async functions in sequence, ensuring that each function is awaited before the next.
  ///
  /// The [key] is used to identify the lock for the current task.
  /// The [action] is the async function to be executed.
  /// It is a Future, the result is awaited before completing the Future. The result is returned immediately.
  ///
  /// Returns a Future that completes with the result of the async function.
  ///
  /// ## Example:
  /// ```dart
  /// await AsyncHelper.instance.executeSequentially('key', () async
  /// {
  ///  // Perform async operation
  ///  return 'result';
  ///  });
  ///  ```
  Future<T> executeSequentially<T>(
      dynamic key, FutureOr<T> Function() action) async {
    // Wait for any ongoing task to complete for the same key
    for (;;) {
      final c = _locks[key];
      if (c == null) break;
      try {
        await c.future;
      } catch (_) {} // Ignore error, continue waiting
    }

    // Create a new Completer for the current task
    final c = _locks[key] = Completer<T>();

    void then(T result) {
      final c2 = _locks.remove(key);
      c.complete(result);

      assert(identical(c, c2));
    }

    void catchError(ex, StackTrace st) {
      final c2 = _locks.remove(key);
      c.completeError(ex, st);

      assert(identical(c, c2));
    }

    try {
      final result = action();
      if (result is Future<T>) {
        result.then(then).catchError(catchError);
      } else {
        then(result);
      }
    } catch (ex, st) {
      catchError(ex, st);
    }

    return c.future;
  }

  /// Handles the cancellation of an animation without throwing errors.
  ///
  /// The [future] is the TickerFuture to catch the TickerCanceled exception.
  /// It is a Future, the result is awaited before completing the Future. The result is returned immediately.
  ///
  /// Returns a Future that completes with the result of the TickerFuture.
  /// - [TickerCanceled] exceptions are caught and ignored.
  ///
  /// ## Example:
  /// ```dart
  /// await AsyncHelper.instance.catchAnimationCancel(controller.forward());
  /// ```
  Future catchAnimationCancel(TickerFuture future) async {
    return future.orCancel.catchError((_) async {
      // Do nothing, skip TickerCanceled exception
      return null;
    }, test: (ex) => ex is TickerCanceled);
  }
}
