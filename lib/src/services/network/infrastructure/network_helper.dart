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

  static dynamic secureContext;

  static const Duration receiveTimeout = Duration(seconds: 300);
  static const Duration connectionTimeout = Duration(seconds: 300);

  /// The shared singleton instance of [NetworkHelper].
  static NetworkHelper? _instance;

  /// Returns the shared singleton instance of [NetworkHelper].
  ///
  /// Creates the instance on first access. All repositories share this
  /// single instance, avoiding duplicate Dio instances, interceptors,
  /// and connection pools.
  static NetworkHelper get instance => _instance ??= NetworkHelper._internal();

  /// Factory constructor that always returns the shared singleton instance.
  ///
  /// This preserves backward compatibility — `NetworkHelper()` now returns
  /// the same instance every time instead of creating a new one.
  factory NetworkHelper() => instance;

  /// Internal constructor that performs the actual initialization.
  NetworkHelper._internal() {
    dio = Dio();
    dio.options = BaseOptions(headers: NetworkConfig.headers);

    // SSL pinning: if secureContext is set, pin certificates and reject bad ones.
    // If secureContext is null, trust all certificates (no pinning).
    // Uses platform-specific adapter (IO on native, no-op on web).
    configureDioAdapter(dio, secureContext);

    if (kDebugMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          settings: TalkerDioLoggerSettings(
            enabled: true,
            printResponseData: true,
            printResponseHeaders: false,
            printResponseMessage: true,
            printErrorData: true,
            printErrorHeaders: true,
            printErrorMessage: true,
            printRequestData: true,
            printRequestHeaders: true,
            errorPen: AnsiPen()..xterm(160),
            requestPen: AnsiPen()..xterm(215),
            responsePen: AnsiPen()..xterm(42),
          ),
        ),
      );
    }

    final DioConnectivityRequest request = DioConnectivityRequest(
      connectivity: Connectivity(),
      dio: dio,
    );
    final RetryInterceptor retryInterceptor = RetryInterceptor(
      dio: request.dio,
      logPrint: Logger.info,
      retries: 3,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 3),
        Duration(seconds: 5),
      ],
    );

    dio
      ..options.connectTimeout = connectionTimeout
      ..options.receiveTimeout = receiveTimeout;

    dio.interceptors.add(retryInterceptor);
  }

  /// Loads a PEM certificate from assets and enables SSL certificate pinning.
  ///
  /// Call this in your `main()` before `runApp()` and before creating any
  /// repositories or [NetworkHelper] instances. If not called, all certificates
  /// are trusted (no pinning).
  ///
  /// [assetPath] is the asset path to the PEM certificate file.
  /// Defaults to `'assets/certificate/certificate.pem'`.
  ///
  /// If the certificate fails to load, a warning is logged and the app
  /// continues without pinning.
  ///
  /// Example:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await NetworkHelper.loadPinningCertificate();
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<void> loadPinningCertificate({
    String assetPath = 'assets/certificate/certificate.pem',
  }) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      NetworkHelper.secureContext = await createSecurityContext(data);

      if (kDebugMode) {
        Logger.info("SSL Certificate loaded successfully");
      }
    } catch (e) {
      // Certificate file not found or failed to load
      // This is not critical - app will work without certificate pinning
      if (kDebugMode) {
        Logger.warning(
            "SSL Certificate not found or failed to load. App will continue without certificate pinning: $e");
      }
      NetworkHelper.secureContext = null;
    }
  }

  /// Adds a custom interceptor to the Dio instance.
  ///
  /// Use this to register interceptors for auth refresh, request signing,
  /// analytics, or any custom request/response processing.
  ///
  /// Example:
  /// ```dart
  /// NetworkHelper.instance.addInterceptor(
  ///   InterceptorsWrapper(
  ///     onRequest: (options, handler) {
  ///       options.headers['X-Custom'] = 'value';
  ///       handler.next(options);
  ///     },
  ///   ),
  /// );
  /// ```
  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  /// Removes a previously added interceptor from the Dio instance.
  void removeInterceptor(Interceptor interceptor) {
    dio.interceptors.remove(interceptor);
  }

  /// Updates the headers in the Dio instance.
  ///
  /// This method takes a map of headers and updates the Dio instance's headers.
  /// It ensures that all headers are properly set for future requests.
  ///
  /// Parameters:
  /// - [headers]: The headers to update or add to the existing headers.
  ///
  /// Returns a boolean indicating whether the headers were successfully updated.
  bool updateHeaders(Map<String, String> headers) {
    try {
      if (headers.isNotEmpty) {
        // Update Dio headers
        headers.forEach((key, value) {
          dio.options.headers[key] = value;
        });
        return true;
      }
      return false;
    } catch (e) {
      Logger.error("Failed to update Dio headers: $e");
      return false;
    }
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
  /// - [requestBodyType]: The type of request body (JSON, FormData, etc.). Defaults to JSON.
  /// - [onSendProgress]: A callback to track the progress of file uploads.
  ///
  /// Returns an [ApiResponse] of the requested type.
  Future<ApiResponse<T?>> request<T>(
    String url,
    Function(Map<String, dynamic>?) create, {
    HTTPMethod method = HTTPMethod.none,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    RequestBodyType? requestBodyType,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
    bool? isGoogleCheck,
    CancelToken? cancelToken,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) async {
    bool connected = await InternetConnectionHandler.checkInternetConnection(
      isGoogleCheck ?? true,
    );

    requestBodyType ??= RequestBodyType.json;

    if (connected) {
      return await _request(
        url,
        create,
        method: method,
        params: params,
        body: body,
        requestBodyType: requestBodyType,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
      );
    } else {
      const exception = NoInternetException();
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
  /// - [requestBodyType]: The type of request body (JSON, FormData, etc.). Defaults to JSON.
  /// - [onSendProgress]: A callback to track the progress of file uploads.
  ///
  /// Returns an [ApiResponse] of the requested type.
  Future<ApiResponse<T>> _request<T>(
    String url,
    Function(Map<String, dynamic>?) create, {
    HTTPMethod method = HTTPMethod.get,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    RequestBodyType? requestBodyType,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
    String? savePath,
    CancelToken? cancelToken,
    Duration? connectTimeout,
    Duration? receiveTimeout,
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
        requestBodyType: requestBodyType,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        savePath: savePath,
        cancelToken: cancelToken,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
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
  /// - [requestBodyType]: The type of request body (JSON, FormData, etc.). Defaults to JSON.
  /// - [onSendProgress]: A callback to track the progress of file uploads for all methods except DELETE.
  /// - [savePath]: The path to save the downloaded file (used for the DOWNLOAD method).
  /// - [onReceiveProgress]: A callback to track the progress of file downloads (used only for the DOWNLOAD method).
  ///
  /// Returns a [Response] from Dio containing the server's response.
  Future<Response> _makeRequest(
    String url, {
    required HTTPMethod method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    RequestBodyType? requestBodyType,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
    String? savePath,
    CancelToken? cancelToken,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) async {
    final data = requestBodyType == RequestBodyType.formData
        ? (body != null ? FormData.fromMap(body) : null)
        : jsonEncode(body);

    final options = Options(
      headers: NetworkConfig.headers,
      sendTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );

    switch (method) {
      case HTTPMethod.get:
        return dio.get(
          url,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
        );
      case HTTPMethod.post:
        return dio.post(
          url,
          queryParameters: params,
          data: data,
          options: options,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken,
        );
      case HTTPMethod.put:
        return dio.put(
          url,
          queryParameters: params,
          data: data,
          options: options,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken,
        );
      case HTTPMethod.patch:
        return dio.patch(
          url,
          queryParameters: params,
          data: data,
          options: options,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken,
        );
      case HTTPMethod.delete:
        return dio.delete(
          url,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
        );
      case HTTPMethod.download:
        return dio.download(
          url,
          savePath,
          queryParameters: params,
          options: options,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
        );
      default:
        throw Exception("Unsupported HTTP method");
    }
  }
}
