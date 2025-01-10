part of '../../services_import.dart';

/// A helper class to manage network requests using Dio.
///
/// This class abstracts the process of making HTTP requests, handles
/// connectivity checks, and provides retries for failed requests. It
/// supports various HTTP methods such as GET, POST, PUT, PATCH, and DELETE.
/// The `request` method allows customization of request parameters, headers,
/// and body, and provides error handling and retry mechanisms.
///
/// Example usage:
/// ```dart
/// final networkHelper = NetworkHelper();
/// ApiResponse<MyModel> response = await networkHelper.request(
///   'https://example.com/api',
///   (json) => MyModel.fromJson(json),
///   method: HTTPMethod.GET,
/// );
/// ```
class NetworkHelper {
  late Dio dio;
  final Connectivity connectivity = Connectivity();

  static const Duration receiveTimeout = Duration(seconds: 300);
  static const Duration connectionTimeout = Duration(seconds: 300);

  /// Initializes the [NetworkHelper] instance and sets up Dio with the
  /// necessary configurations, including request timeouts, headers, logging,
  /// and retry mechanisms.
  ///
  /// The constructor also adds Dio interceptors for logging in debug mode
  /// and handles retries on network failures using the [RetryConnection]
  /// class.
  NetworkProvider() {
    dio = Dio();
    dio.options = BaseOptions(headers: NetworkConfig.headers);

    if (kDebugMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          settings: TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printRequestData: true,
            printResponseHeaders: false,
            printResponseData: true,
            printResponseMessage: false,
            errorPen: AnsiPen()..xterm(160),
            requestPen: AnsiPen()..xterm(215),
            responsePen: AnsiPen()..xterm(42),
          ),
        ),
      );
    }

    final request = DioConnectivityRequest(
      connectivity: Connectivity(),
      dio: dio,
    );
    final retryInterceptor = RetryConnection(
      request: request,
    );

    dio
      ..options.connectTimeout = connectionTimeout
      ..options.receiveTimeout = receiveTimeout;

    dio.interceptors.add(retryInterceptor);
  }

  /// Makes a network request with the specified parameters.
  ///
  /// This method performs a connectivity check before sending the request.
  /// If the device is connected to the internet, it proceeds to make the
  /// request using the [_request] method. If no internet connection is
  /// detected, it returns an exception response.
  ///
  /// The [create] function is used to map the response data into the desired
  /// model type.
  ///
  /// Parameters:
  /// - [url]: The URL for the request.
  /// - [create]: A function to create the desired model from the response data.
  /// - [method]: The HTTP method to use for the request (GET, POST, etc.).
  /// - [params]: Query parameters for the request.
  /// - [body]: The body of the request (used for methods like POST, PUT, etc.).
  /// - [rawData]: If true, sends the body as raw data (default is false).
  /// - [onSendProgress]: A callback to track the progress of file uploads.
  ///
  /// Returns an [ApiResponse] of the requested type.
  Future<ApiResponse<T?>> request<T>(
    String url,
    Function(Map<String, dynamic>?) create, {
    HTTPMethod method = HTTPMethod.NONE,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    bool rawData = false,
    Function? onSendProgress,
  }) async {
    bool connected = await InternetConnectionHandler.isInternetConnected();
    if (connected) {
      return await _request(
        url,
        create,
        method: method,
        params: params,
        body: body,
        rawData: rawData,
      );
    } else {
      Exception exception = Exception(487);
      ApiResponse response = ApiResponse<T>.exception(exception);
      return response as FutureOr<ApiResponse<T?>>;
    }
  }

  /// Performs the network request using the provided method and parameters.
  ///
  /// This method is used internally by [request] and directly interacts
  /// with Dio to send the request to the server. It handles different
  /// HTTP methods (GET, POST, PUT, PATCH, DELETE) and returns the response
  /// wrapped in an [ApiResponse].
  ///
  /// Parameters:
  /// - [url]: The URL for the request.
  /// - [create]: A function to create the desired model from the response data.
  /// - [method]: The HTTP method to use for the request (GET, POST, etc.).
  /// - [params]: Query parameters for the request.
  /// - [body]: The body of the request (used for methods like POST, PUT, etc.).
  /// - [rawData]: If true, sends the body as raw data (default is false).
  /// - [onSendProgress]: A callback to track the progress of file uploads.
  ///
  /// Returns an [ApiResponse] of the requested type.
  Future<ApiResponse<T>> _request<T>(
    String url,
    Function(Map<String, dynamic>?) create, {
    HTTPMethod method = HTTPMethod.GET,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    bool rawData = false,
    Function(int, int)? onSendProgress,
  }) async {
    params ??= {};
    body ??= {};

    dio.options.headers = NetworkConfig.headers;

    try {
      // Use the `_makeRequest` method to handle all HTTP methods.
      final Response response = await _makeRequest(
        url,
        method: method,
        params: params,
        body: body,
        rawData: rawData,
        onSendProgress: onSendProgress,
      );

      // Return success response.
      return ApiResponse<T>.success(response, create);
    } on DioException catch (e) {
      // Handle Dio exceptions.
      return ApiResponse<T>.error(e);
    } on Exception catch (exception) {
      // Handle other exceptions.
      return ApiResponse<T>.exception(exception);
    }
  }

  /// Makes the actual HTTP request using Dio for various methods.
  ///
  /// This method handles the specific HTTP method (GET, POST, PUT, PATCH,
  /// DELETE) and returns the Dio response.
  ///
  /// Parameters:
  /// - [url]: The URL for the request.
  /// - [method]: The HTTP method to use for the request.
  /// - [params]: Query parameters for the request.
  /// - [body]: The body of the request (used for methods like POST, PUT, etc.).
  /// - [rawData]: If true, sends the body as raw data (default is false).
  /// - [onSendProgress]: A callback to track the progress of file uploads.
  ///
  /// Returns a [Response] from Dio containing the server's response.
  Future<Response> _makeRequest(
    String url, {
    required HTTPMethod method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    bool rawData = false,
    Function(int, int)? onSendProgress,
  }) async {
    final data = rawData
        ? jsonEncode(body)
        : (body != null ? FormData.fromMap(body) : null);

    switch (method) {
      case HTTPMethod.GET:
        return dio.get(
          url,
          queryParameters: params,
          options: Options(headers: NetworkConfig.headers),
        );
      case HTTPMethod.POST:
        return dio.post(
          url,
          queryParameters: params,
          data: data,
          options: Options(headers: NetworkConfig.headers),
          onSendProgress: onSendProgress,
        );
      case HTTPMethod.PUT:
        return dio.put(
          url,
          queryParameters: params,
          data: data,
          options: Options(headers: NetworkConfig.headers),
        );
      case HTTPMethod.PATCH:
        return dio.patch(
          url,
          queryParameters: params,
          data: data,
          options: Options(headers: NetworkConfig.headers),
        );
      case HTTPMethod.DELETE:
        return dio.delete(
          url,
          queryParameters: params,
          options: Options(headers: NetworkConfig.headers),
        );
      default:
        throw Exception("Unsupported HTTP method");
    }
  }
}
