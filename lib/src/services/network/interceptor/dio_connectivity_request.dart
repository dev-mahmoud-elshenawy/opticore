import 'dart:async';

import 'package:opticore/opticore.dart';

/// A class that facilitates retrying HTTP requests when the internet connection is restored.
///
/// This class uses the `Connectivity` plugin to listen for changes in the network connectivity
/// status and attempts to retry the request once the internet connection is restored.
/// It is specifically useful for scenarios where an app needs to handle requests when
/// there's an intermittent internet connection or when the user is offline.
///
/// It utilizes the `Dio` HTTP client to make the request and allows customization of request parameters.
/// A `Completer` is used to handle the asynchronous completion of the request, ensuring it retries
/// once the connectivity is available.
///
/// Example usage:
/// ```dart
/// final dio = Dio();
/// final connectivity = Connectivity();
/// final dioConnectivityRequest = DioConnectivityRequest(dio: dio, connectivity: connectivity);
/// dioConnectivityRequest.scheduleRequestRetry(requestOptions);
/// ```
class DioConnectivityRequest {
  DioConnectivityRequest({
    required this.dio,
    required this.connectivity,
  });

  /// The `Dio` client used for making HTTP requests.
  ///
  /// This client is used to send the request once the internet connection is restored.
  final Dio dio;

  /// The `Connectivity` plugin used for listening to internet connectivity changes.
  ///
  /// This listens to changes in connectivity (online/offline status) and triggers a retry of
  /// the request when a connection is re-established.
  final Connectivity connectivity;

  /// Schedules a retry of the request once the internet connection is restored.
  ///
  /// This method listens for changes in the internet connectivity status. Once a connection
  /// is available (i.e., not `ConnectivityResult.none`), it will retry the HTTP request
  /// using the `Dio` client.
  ///
  /// If the request takes too long, it will timeout after the specified duration in
  /// `NetworkHelper.connectionTimeout`.
  ///
  /// [requestOptions] - The `RequestOptions` containing the details of the request to be retried.
  ///
  /// Returns a [Future<Response>] that will complete once the request is successfully sent.
  /// If the request fails, it will return an error.
  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    try {
      // Listens for changes in connectivity status.
      streamSubscription = connectivity.onConnectivityChanged.listen(
        (connectivityResult) async {
          // Only proceed if the device has internet connectivity
          if (!connectivityResult.contains(ConnectivityResult.none)) {
            // Ensure the request is not already in progress
            if (!responseCompleter.isCompleted) {
              streamSubscription
                  .cancel(); // Stop listening after connection is restored.
              try {
                // Attempt to send the request again using Dio
                final response = await dio.request<dynamic>(
                  requestOptions.path,
                  cancelToken: requestOptions.cancelToken,
                  data: requestOptions.data,
                  onReceiveProgress: requestOptions.onReceiveProgress,
                  onSendProgress: requestOptions.onSendProgress,
                  queryParameters: requestOptions.queryParameters,
                  options: Options(
                    headers: requestOptions.headers,
                    contentType: requestOptions.contentType,
                    followRedirects: requestOptions.followRedirects,
                    listFormat: requestOptions.listFormat,
                    maxRedirects: requestOptions.maxRedirects,
                    method: requestOptions.method,
                    receiveDataWhenStatusError:
                        requestOptions.receiveDataWhenStatusError,
                    receiveTimeout: requestOptions.receiveTimeout,
                    requestEncoder: requestOptions.requestEncoder,
                    responseDecoder: requestOptions.responseDecoder,
                    responseType: requestOptions.responseType,
                    sendTimeout: requestOptions.sendTimeout,
                    validateStatus: requestOptions.validateStatus,
                  ),
                );
                // Completes the future with the response.
                responseCompleter.complete(response);
              } catch (error) {
                // In case of an error, complete with an error.
                responseCompleter.completeError(error);
              }
            }
          }
        },
      );
    } catch (error) {
      // Completes with an error in case of failure in setup.
      responseCompleter.completeError(error);
    }

    // Set a timeout for the operation to avoid indefinite waiting.
    return responseCompleter.future.timeout(
      NetworkHelper.connectionTimeout, // Timeout duration from `NetworkHelper`.
      onTimeout: () {
        streamSubscription.cancel(); // Cancel the subscription on timeout.
        return Future.error('Request timed out');
      },
    );
  }
}
