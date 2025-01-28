import 'package:opticore/opticore.dart';

import 'dio_connectivity_request.dart';

/// A custom interceptor that handles request retries based on network connectivity and error conditions.
///
/// This interceptor is designed to manage retries for Dio requests when there are issues with connectivity,
/// or when a timeout occurs. It listens for connectivity changes and, if the error is due to a network timeout
/// or a temporary loss of connection, it will attempt to retry the request once the connectivity is restored.
///
/// The retry logic considers the type of error and whether it's an appropriate case for retrying the request.
/// This class is useful in scenarios where network instability can cause transient errors, and automatic retries
/// can help ensure successful request completion.
///
/// ## Usage
/// This interceptor should be added to the Dio instance's interceptors chain. It works alongside the
/// [DioConnectivityRequest] to handle retries and can be customized to trigger actions upon timeouts via
/// the [onTimeOut] callback.
class RetryConnection extends QueuedInterceptorsWrapper {
  /// Creates an instance of [RetryConnection] that manages retries based on connectivity status and error types.
  ///
  /// The [request] parameter is the [DioConnectivityRequest] that performs the retry logic by rescheduling
  /// the request when network connectivity is restored. The optional [onTimeOut] callback allows you to specify
  /// custom behavior when a timeout occurs during a request.
  ///
  /// [onTimeOut] is a callback that is invoked if the request times out. You can use it to show notifications
  /// or handle timeouts in a custom way.
  RetryConnection({
    required this.request,
    this.onTimeOut,
  });

  /// The [DioConnectivityRequest] instance responsible for handling the retry logic.
  /// It performs the actual retry attempts when the connectivity changes from offline to online.
  final DioConnectivityRequest request;

  /// A callback function that is triggered when a request times out.
  /// This callback is optional and can be used to handle timeout events in a custom way, such as
  /// showing a user-friendly timeout message or logging the event.
  final Function()? onTimeOut;

  /// Called before the request is sent. This method can be used to manipulate or log the request
  /// before it is processed.
  ///
  /// The request continues to the next interceptor after this method is executed.
  ///
  /// This method does not modify the request unless explicitly specified.
  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Optionally log or modify request here
    return handler.next(options); // Continue with the request
  }

  /// Called before the response is returned to the application.
  /// This method allows you to modify the response or log it before passing it to the application.
  ///
  /// This method does not alter the response unless explicitly specified.
  ///
  /// After executing this method, the response will proceed to the next interceptor.
  @override
  Future<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // Optionally log or modify response here
    return handler.next(response); // Continue with the response
  }

  /// Called when an error occurs during the request. This method is used to determine if the request should be retried.
  ///
  /// If the error is due to network connectivity or timeout, the request is retried using the [DioConnectivityRequest].
  /// If the error is not retryable (such as a client cancellation or a bad response), it will be passed to the next handler.
  ///
  /// If a retry is triggered, the [scheduleRequestRetry] method of the [DioConnectivityRequest] is called.
  /// In case of failure to retry, the error is passed to the handler.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err)) {
      try {
        // Attempt to retry the request
        request.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        // If retry fails, pass the error to the next handler
        handler.next(err.error as DioException);
      }
    } else {
      // If the error is not retryable, reject it
      handler.reject(err);
    }
  }

  /// Determines whether the error should trigger a retry attempt.
  ///
  /// The decision to retry is based on the error type. The retry will be attempted if the error is not a
  /// cancellation or a bad response. If the error is a timeout, the [onTimeOut] callback (if provided) will be triggered.
  ///
  /// The method ensures that retry logic is applied only to appropriate error types.
  bool _shouldRetry(DioException error) {
    final status = error.type != DioExceptionType.cancel &&
        error.type != DioExceptionType.badResponse; // Retryable errors
    if (_isTimeOut(error)) {
      // If timeout occurs, invoke the timeout handler
      onTimeOut?.call();
    }
    return status; // Return true if retry is allowed
  }

  /// Checks if the error is related to a timeout.
  ///
  /// A timeout can occur in several situations, such as when there is no response from the server or
  /// when the request takes too long to complete. This method checks for the following timeout-related errors:
  /// - [DioExceptionType.connectionTimeout]
  /// - [DioExceptionType.sendTimeout]
  /// - [DioExceptionType.receiveTimeout]
  bool _isTimeOut(DioException error) =>
      error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.sendTimeout ||
      error.type == DioExceptionType.receiveTimeout;
}
