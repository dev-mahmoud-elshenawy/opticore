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

  static SecurityContext? secureContext;

  static const Duration receiveTimeout = Duration(seconds: 300);
  static const Duration connectionTimeout = Duration(seconds: 300);

  /// Initializes the [NetworkHelper] instance and sets up Dio with the
  /// necessary configurations, including request timeouts, headers, logging,
  /// and retry mechanisms.
  ///
  /// The constructor also adds Dio interceptors for logging in debug mode
  /// and handles retries on network failures using the [RetryConnection]
  /// class.
  NetworkHelper() {
    dio = Dio();
    dio.options = BaseOptions(headers: NetworkConfig.headers);

    // Load certificate pinning
    loadPinningCertificate();

    // Configure SSL pinning with IOHttpClientAdapter (Dio 5.x syntax)
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient httpClient = HttpClient(context: secureContext);
        httpClient.badCertificateCallback = (cert, host, port) {
          Logger.error("Bad Certificate");
          return false;
        };
        return httpClient;
      },
    );

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
  static Future<void> loadPinningCertificate() async {
    try {
      final ByteData data =
          await rootBundle.load('assets/certificate/certificate.pem');
      SecurityContext securityContext =
          SecurityContext(withTrustedRoots: false);

      // Fixed typo: asUnit8List() -> asUint8List()
      securityContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

      // Fixed: Can't use 'this' in static method
      NetworkHelper.secureContext = securityContext;

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
  }) async {
    final data = requestBodyType == RequestBodyType.formData
        ? (body != null ? FormData.fromMap(body) : null)
        : jsonEncode(body);

    switch (method) {
      case HTTPMethod.get:
        return dio.get(
          url,
          queryParameters: params,
          options: Options(headers: NetworkConfig.headers),
        );
      case HTTPMethod.post:
        return dio.post(
          url,
          queryParameters: params,
          data: data,
          options: Options(headers: NetworkConfig.headers),
          onSendProgress: onSendProgress,
        );
      case HTTPMethod.put:
        return dio.put(
          url,
          queryParameters: params,
          data: data,
          options: Options(headers: NetworkConfig.headers),
          onSendProgress: onSendProgress,
        );
      case HTTPMethod.patch:
        return dio.patch(
          url,
          queryParameters: params,
          data: data,
          options: Options(headers: NetworkConfig.headers),
          onSendProgress: onSendProgress,
        );
      case HTTPMethod.delete:
        return dio.delete(
          url,
          queryParameters: params,
          options: Options(headers: NetworkConfig.headers),
        );
      case HTTPMethod.download:
        return dio.download(
          url,
          savePath,
          queryParameters: params,
          options: Options(headers: NetworkConfig.headers),
          onReceiveProgress: onReceiveProgress,
        );
      default:
        throw Exception("Unsupported HTTP method");
    }
  }
}
